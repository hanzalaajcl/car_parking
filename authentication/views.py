from django.shortcuts import render
from rest_framework_simplejwt.views import TokenObtainPairView
from .serializers import (CustomTokenObtainPairSerializer,CreateUserSerializer,CustomPasswordChangeSerializer,UserAttendanceSerializer)
from rest_framework import generics, permissions
from .permissions import IsAdmin,IsUser
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from django.forms.models import model_to_dict
from .models import Users
from django_rest_passwordreset.views import (ResetPasswordConfirm)
# Create your views here.


class UserLoginView(TokenObtainPairView):
    permission_classes = [permissions.AllowAny]
    serializer_class = CustomTokenObtainPairSerializer
    
    
    
    
class UserRegisterView(generics.CreateAPIView):
    permission_classes = [IsAdmin]
    serializer_class = CreateUserSerializer
    
    
    
class GetProfileView(APIView):
    permission_classes = [permissions.AllowAny]
    
    def get(self, request, *args, **kwargs):
        resp = {
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'All Profile Details',
            'data': []
        }
        users = list(map(lambda x: {'email':x.email,'role':x.role.name,
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
                                    # 'profile_image':x.profile_image.url if x.profile_image else None,
                                    
        },Users.objects.filter(role__name = 'user'))) 
        
        resp['data'] = users
        return Response(resp)

    
    
class ChangePasswordVew(generics.CreateAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = CustomPasswordChangeSerializer
    
    
    
class UserAttendence(generics.CreateAPIView):
    permission_classes = [IsAdmin]
    serializer_class = UserAttendanceSerializer
    
    
    
    

    
    
 
