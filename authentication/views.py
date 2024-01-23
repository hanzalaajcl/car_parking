from django.shortcuts import render
from rest_framework_simplejwt.views import TokenObtainPairView
from .serializers import (CustomTokenObtainPairSerializer,CreateUserSerializer,CustomPasswordChangeSerializer,UserAttendenceSerializer,RegisterSerializer)
from rest_framework import generics, permissions
from .permissions import IsAdmin,IsUser
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from django.forms.models import model_to_dict
from .models import UserAttendance, Users
from django_rest_passwordreset.views import (ResetPasswordConfirm)
# Create your views here.

    
class AdminSignupRegisterView(APIView):
    permission_classes = [permissions.AllowAny]
    # serializer_class = RegisterSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            response_data = serializer.save()
            # Use the status code from the serializer's response
            return Response(response_data, status=response_data.get('status_code', status.HTTP_200_OK))
        else:
            # Handle invalid serializer with a 400 status code
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
class UserLoginView(TokenObtainPairView):
    permission_classes = [permissions.AllowAny]
    serializer_class = CustomTokenObtainPairSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
        except Exception as e:
            # Handle validation errors and set the response status code
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        response_data = serializer.validated_data
        print("Response data", response_data)
        return Response(response_data, status=response_data.get('status_code', status.HTTP_200_OK))
    
    
    
    
class UserRegisterView(APIView):
    permission_classes = [IsAdmin]
    
    def post(self, request, *args, **kwargs):
        serializer = CreateUserSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            response_data = serializer.save()
            # Use the status code from the serializer's response
            return Response(response_data, status=response_data.get('status_code', status.HTTP_200_OK))
        else:
            # Handle invalid serializer with a 400 status code
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
class GetProfileView(APIView):
    permission_classes = [permissions.AllowAny]
    
    def get(self, request, *args, **kwargs):
        resp = {
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'All Profile Details',
            'data': []
        }
        users = Users.objects.filter(role__name = 'user')
        details = list(map(lambda x: {'id':x.pk,
                                    'email':x.email,
                                    'role':x.role.name,
                                    'first_name':x.first_name,
                                    'last_name':x.last_name,
                                    'cnic':x.cnic,
                                    'age':x.age,
                                    'gender':x.gender,
                                    'hired_date':x.hired_date,
                                    'hired_time':x.hired_time,
                                    'status':x.status,
                                    # 'register_by':model_to_dict(x.register_by),
                                    'register_date':x.register_date,
                                    'register_time':x.register_time,
                                    'profile_image':x.get_main_image(),
                                    'attendance': x.user_attendance.first().status if x.user_attendance.exists() and x.user_attendance.first() else None
                                    # 'profile_image':x.profile_image.url if x.profile_image else None,
                                    
        },users)) 
        
        resp['data'] = details
        return Response(resp,status=resp['status_code'])

    
    
class ChangePasswordVew(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = CustomPasswordChangeSerializer
    
    
    

    
class UserAttendence(APIView):
    permission_classes = [IsAdmin]
    
    def post(self, request, *args, **kwargs):
        serializer = UserAttendenceSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            response_data = serializer.save()
            # Use the status code from the serializer's response
            return Response(response_data, status=response_data.get('status_code', status.HTTP_200_OK))
        else:
            # Handle invalid serializer with a 400 status code
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class GetUserAttendanceStatus(APIView):
    permission_classes = [IsAdmin]
    
    def get(self,request):
        resp = {
          'status': True,
          'status_code': status.HTTP_200_OK,
          'message': 'All Attendance Details',
          'data': []
        }
        user_attendence = UserAttendance.objects.all()
        resp['data'] = list(map(lambda x: {'user_id':x.user.pk,
                                           'user_email': x.user.email,
                                           'first_name': x.user.first_name,
                                           'last_name': x.user.last_name,
                                           'cnic':x.user.cnic,
                                           'gender':x.user.gender,
                                           'hired_date':x.user.hired_date,
                                           'hired_time':x.user.hired_time,
                                           'status':x.status,
                                           },user_attendence))
        return Response(resp,status=resp['status_code'])
    


    

    
    
 
