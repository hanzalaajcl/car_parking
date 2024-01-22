from django.forms import model_to_dict
from  .models import Role, UserAttendance, Users
from rest_framework import serializers, status
from django.db.models import Q
from django.contrib.auth import authenticate
from rest_framework_simplejwt.settings import api_settings
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth.models import update_last_login
import uuid,random
from django.db import transaction
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.conf import settings
from django.utils.translation import gettext as _
import magic
from .utils import verify_email_on_user_registeration 
from datetime import datetime   
from parking.models import ParkingPlaza,UserAllocation

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.user = None
        self.fields["email"] = serializers.CharField(required = True)
        self.fields["password"] = serializers.CharField(required = True)
    
    def validate(self, attrs):
        email = attrs.get('email')
        password = attrs.get('password')
        try:
            user_obj = Users.objects.get(email=email)
            print(user_obj)
        except Users.DoesNotExist as e:
            user_obj =  None
        if user_obj is not None:
            authenticate_kwargs = {
                "email": user_obj.email,
                "password": password,
            }
            print("authenticate_kwargs",authenticate_kwargs)
            try:
                authenticate_kwargs["request"] = self.context["request"]
            except KeyError:
                pass

            self.user = authenticate(**authenticate_kwargs)
            print("self.user", self.user)
            if not api_settings.USER_AUTHENTICATION_RULE(self.user):
                return {'message': 'Invalid password'}
            else:
                data = {
                    'email' : self.user.email,
                    'role' : self.user.role.name
                }
                return data 
        else:
            return {'message': 'Invalid email or username'}
        
    @classmethod
    def get_token(cls, user):
        return super().get_token(user)


class CustomTokenObtainPairSerializer(MyTokenObtainPairSerializer):
    
    token_class = RefreshToken
    def validate(self, attrs):
        response = {"status" : False,"status_code"  : None, "message" : None, "data" : None}
        data = super().validate(attrs)
        if 'message' not in data.keys():
            print(data)
            refresh = self.get_token(self.user)
            response["status"] = True
            
            response["status_code"] = status.HTTP_200_OK
            response["message"] = "Login Successfully"
            response["data"] = data
            response['data']["refresh"] = str(refresh)
            response['data']["access"] = str(refresh.access_token)
            
            if api_settings.UPDATE_LAST_LOGIN:
                update_last_login(None, self.user)
        else:
            response["status"] = False
            response["message"] = data["message"]
            response["status_code"] = status.HTTP_400_BAD_REQUEST
        return response





class CreateUserSerializer(serializers.Serializer):
    status_code = serializers.IntegerField(read_only=True,default=status.HTTP_201_CREATED)
    status = serializers.BooleanField(read_only=True)
    message = serializers.CharField(read_only=True,default=None)
    data = serializers.DictField(read_only=True,default={})
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.resp = {'status' : False, 'message' : None,'data' : None,'status_code' : status.HTTP_200_OK} 
        request = self.context["request"]
        self.request = request
        self.user = request.user
        self.fields["email"] = serializers.EmailField(required = True,write_only=True)
        self.fields["first_name"] = serializers.CharField(required = True,write_only=True)
        self.fields["last_name"] = serializers.CharField(required = True,write_only=True)
        self.fields["cnic"] = serializers.CharField(required = True,write_only=True)
        self.fields["age"] = serializers.IntegerField(required = True,write_only=True)
        self.fields["gender"] = serializers.CharField(required = True,write_only=True)
        self.fields["hired_date"] = serializers.CharField(required = True,write_only=True)
        self.fields["hired_time"] = serializers.CharField(required = True,write_only=True)
        self.fields["profile_image"] = serializers.FileField(required = False,write_only=True)
        self.fields["plaza_id"] = serializers.CharField(required = True,write_only=True)
        
    
    def validate(self, attrs):
        attrs['request'] = self.request
        errors = None
        attrs['valid'] = True
        email = attrs.get('email')
        
        hired_date = attrs.get('hired_date')
        hired_time = attrs.get('hired_time')
        
        plaza_id = attrs.get('plaza_id')
        
        profile_image = attrs.get('profile_image')
        if Users.objects.filter(email=email).exists():
            errors = "This email is already taken."
        plaza_qs = ParkingPlaza.objects.filter(pk = plaza_id)
        if len(plaza_qs) <= 0:
            errors = "Given plaza id is not found."
        else:
            plaza_obj = plaza_qs.first()
            attrs['plaza_obj'] = plaza_obj
            
        
            
        if attrs['valid'] and profile_image is not None:
            file_type = magic.from_buffer(profile_image.read(), mime=True).split("/")[0]
            if file_type not in ("image"):
                errors = f"Image is not a valid media type."
                print(errors)
            else:
                pass
        try:
            hired_date = datetime.strptime(hired_date, "%d/%m/%Y").date()
            attrs['hired_date'] = hired_date
        except:
            errors = "The hired date should be in the format 'DD/MM/YYYY'."
            attrs['valid'] = False
            
            
        try:
            hired_time = datetime.strptime(hired_time, "%H:%M:%S").time()
            attrs['hired_time'] = hired_time
            
        except:
            errors = "The hired time should be in the format 'HH:MM:SS'."
            attrs['valid'] = False
            
            
        if errors is None:
            attrs['valid'] = True
        else:
            attrs['error'] = errors
            attrs['valid'] = False
            
        return attrs
    
    
    
    def create(self, validated_data):
        print("validated_data:", validated_data)
        if validated_data['valid'] == True:
            role = Role.objects.filter(name = 'user').first()
            with transaction.atomic():
                print(validated_data['hired_time'])
                user_obj = Users.objects.create(
                    email=validated_data['email'],
                    role = role,
                    first_name=validated_data['first_name'],
                    last_name=validated_data['last_name'],
                    cnic=validated_data['cnic'],
                    age=validated_data['age'],
                    gender=validated_data['gender'],
                    hired_date=validated_data['hired_date'],
                    hired_time=validated_data['hired_time'],
                    register_by=self.user,
                    status = 'Unverified',
                )
                
                
                user_obj.set_password('Ajcl@123#')
                user_obj.save()
                
                if 'profile_image' in validated_data:
                    user_obj.profile_image = validated_data['profile_image']
                    user_obj.save()
                
                verify_email_on_user_registeration(self,self.request,validated_data['email'],user_obj)
                UserAllocation.objects.create(
                    user = user_obj,
                    assigned_by = self.user,
                    parking_plaza = validated_data['plaza_obj']
                )
                self.resp['status'] = True 
                self.resp['status_code'] = status.HTTP_201_CREATED
                self.resp['message'] = 'User created successfully'
                self.resp["data"] = {
                "email" : validated_data['email'] }
        else:
            self.resp["status_code"] = status.HTTP_400_BAD_REQUEST
            self.resp["status"] = False
            self.resp["data"] = {}
            self.resp['message'] = validated_data.get('error')
            
        return self.resp
        
        

        



class CustomPasswordChangeSerializer(serializers.Serializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.resp = {'status' : False, 'message' : None,'data' : None,'status_code' : status.HTTP_200_OK} 
        request = self.context["request"]
        self.user = request.user
        self.fields["new_password1"] = serializers.CharField(write_only=True)
        self.fields["new_password2"] = serializers.CharField(write_only=True)
        self.fields["old_password"] = serializers.CharField(write_only=True)

    def validate(self, attrs):
        attrs['valid'] = True
        old_password = attrs['old_password']
        password = attrs['new_password1']
        confirm_password = attrs['new_password2']
        
        user_obj = authenticate(email=self.user.email,password=old_password)

        if attrs['valid'] and user_obj is None:
            self.resp['message'] = "Invalid old password"
            self.resp["status_code"] = status.HTTP_401_UNAUTHORIZED
            attrs['valid'] = False
        
        if attrs['valid'] and password != confirm_password:
            self.resp["message"] = "Both passwords must be same."
            self.resp["status_code"] = status.HTTP_400_BAD_REQUEST
            attrs['valid'] = False
        
        if attrs['valid'] and password == old_password:
            self.resp["message"] = "New passwords must be distinct then old password."
            self.resp["status_code"] = status.HTTP_400_BAD_REQUEST
            attrs['valid'] = False

        
        return attrs
    
    def create(self,validated_data):
        if validated_data['valid'] == True:
            self.user.set_password(validated_data['new_password2'])
            self.user.save()
            self.resp["status"] = True
            self.resp["status_code"] = status.HTTP_200_OK
            self.resp["message"] = "Password changed successfully"
        print("self.rep",self.resp)
        return self.resp
    
    
    
    
# class UserAttendanceSerializer(serializers.Serializer):
#     status_code = serializers.IntegerField(read_only=True,default=status.HTTP_201_CREATED)
#     status = serializers.BooleanField(read_only=True)
#     message = serializers.CharField(read_only=True,default=None)
#     data = serializers.DictField(read_only=True,default={})
    
#     def __init__(self, *args, **kwargs):
#         super().__init__(*args, **kwargs)
#         self.resp = {'status' : False, 'message' : None,'data' : None,'status_code' : status.HTTP_200_OK} 
#         request = self.context["request"]
#         self.request = request
#         self.user = request.user
#         self.fields["user_ids"] = serializers.ListField(required = True,write_only=True)
#         self.fields["status"] = serializers.CharField(required = True,write_only=True)
#         self.fields["date"] = serializers.CharField(required = False,write_only=True)
        
#     def validate(self, attrs):
#         errors = None
#         attrs['valid'] = True
#         data = attrs.get('data',None)
#         if data is not None:
#             try:
#                 date = datetime.strptime(date, "%d/%m/%Y").date()
#                 attrs['date'] = date
#             except ValueError:
#                 errors = "date should be in the format 'DD/MM/YYYY'."
#                 attrs['valid'] = False
#         else:
#             attrs['date'] = datetime.now().date()
                
            
#         user_ids = attrs.get('user_ids')
#         print(user_ids,"================================")
#         status = attrs.get('status')
#         users = user_ids[0].split(",")  
#         print(users,'++++++++++++++++')      
#         user_id = 0
#         users_list = []
#         for user_pk in users:
#             print(user_pk,"pppppppppppppppppp")
#             user_qs = Users.objects.filter(pk = user_pk)
#             user_id+=1
#             if user_qs.exists():
#                 users_list.append(user_pk)
#             else:
#                 errors = f"User with id {user_id} is not found."
#                 attrs['valid'] = False
                
#         if status is not ['present','absent','on_leave']:
#             errors = "Status should be 'present','absent','on_leave'."
#             attrs['valid'] = False
            
#         if errors is not None:
#             attrs['error'] = errors
#             attrs['valid'] = False
#         else:
#             attrs['user_qs'] = users_list
            
#         return attrs
        
        
#     def create(self, validated_data):
#         if validated_data['valid'] == True:
#             for user in validated_data['user_qs']:
#                 for i in user:
#                     user_attendence = UserAttendance.objects.create(
#                         user = i,
#                         updated_by = self.user,
#                         status = validated_data['status']
                        
#                     )
#             self.resp["status"] = True
#             self.resp["status_code"] = status.HTTP_201_CREATED
#             self.resp["message"] = "Attendance updated successfully"
#             self.resp["data"] = model_to_dict(user_attendence)
#         else:
#             self.resp["status"] = False
#             self.resp["status_code"] = status.HTTP_400_BAD_REQUEST
#             self.resp['message'] = validated_data['error']
#         return self.resp
    
    
    
    
    
    



class UserAttendenceSerializer(serializers.Serializer):
    status_code = serializers.IntegerField(read_only=True,default=status.HTTP_201_CREATED)
    status = serializers.BooleanField(read_only=True)
    message = serializers.CharField(read_only=True,default=None)
    data = serializers.DictField(read_only=True,default={})
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.resp = {'status' : False, 'message' : None,'data' : None,'status_code' : status.HTTP_200_OK} 
        request = self.context["request"]
        self.request = request
        self.user = request.user
        self.fields["attendance"] = serializers.ListField(child=serializers.DictField(), required=True,write_only=True)
        # self.fields["date"] = serializers.CharField(required = False,write_only=True)
        
    '''{"attendance": [
        { "user_id" : 1,"status": "absent"},
        { "user_id" : 2,"status": "present"},
        ]}'''
        

        
        
    def validate(self, attrs):
        errors = None
        attrs['valid'] = False
        attrs['for_update'] = False
        for idx, attend in enumerate(attrs.get('attendance', [])):
            user_qs = Users.objects.filter(pk =  attend['user_id'])
            if 'user_id' not in attend.keys():
                errors = 'user_id is required'
                
            if 'status' not in attend.keys():
                errors = 'user_id is required'
                
            else:
                print(attend,"++++++++++++++++")
                if attend['status'] not in ['present','absent','on_leave']:
                    errors = "Status should be 'present','absent','on_leave'."
                else:
                    pass
            if not user_qs.exists():
                errors = 'User not found of given user_id'
            else:
                if UserAttendance.objects.filter(user = user_qs.first()).exists():
                    attrs['for_update'] = True
            print(errors,"00000000")
            if errors is not None:
                attrs['errors'] = errors
                attrs['valid'] = False
            else:
                attrs['user_obj'] = user_qs.first()
                attrs['attend_status'] = attend['status']
                attrs['valid'] = True
        print(attrs,"+++++++hello+++++++++")
        return attrs
    
    
    def create(self, validated_data):
        if validated_data['valid'] == True:
            with transaction.atomic():
                if validated_data['for_update'] == True:
                    user_allocate = UserAttendance.objects.filter(user = validated_data['user_obj']).first()
                    user_allocate.status = validated_data['attend_status']
                    user_allocate.save()
                else:
                    UserAttendance.objects.create(user = validated_data['user_obj'],
                                                  status = validated_data['attend_status'],
                                                  updated_by = self.user,
                                                  )
                    
                self.resp['message'] = 'Attendence created or updated successfully'
        else:
            self.resp['message'] = validated_data['errors']
            self.resp['status'] = False
            self.resp['status_code'] = status.HTTP_400_BAD_REQUEST
        return self.resp
    
    
    
    
    
    
    

    
    
    
    
    '''{attendances_of_user": {
        'attendance': [
        { "user_id" : 1,"status": "absent"},
        { "user_id" : 2,"status": "present"},
        ],
        'date': '2021-01-01'
        }}'''
        
        
        
        
# class AttendanceSerializer(serializers.Serializer):
#     user_id = serializers.IntegerField()
#     status = serializers.CharField()

# class AttendancesSerializer(serializers.Serializer):
#     attendance = AttendanceSerializer(many=True)

#     def validate_attendance(self, value):
#         print(value,"++++++++++++++++")
#         # Validate each attendance entry
#         for attend in value:
#             user_id = attend.get('user_id')
#             status = attend.get('status')

#             if user_id is None:
#                 raise serializers.ValidationError("user_id is required")

#             if status is None:
#                 raise serializers.ValidationError("status is required")

#             if status not in ['present', 'absent', 'on_leave']:
#                 raise serializers.ValidationError("Status should be 'present', 'absent', 'on_leave'.")

#             user_qs = Users.objects.filter(pk=user_id)
#             if not user_qs.exists():
#                 raise serializers.ValidationError(f"User not found for user_id: {user_id}")

#         return value