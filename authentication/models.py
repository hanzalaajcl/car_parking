from django.db import models
from django.contrib.auth.models import  BaseUserManager
from django.utils import timezone
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
import os
from datetime import datetime ,date
from django.conf import settings




def save_profile_image(instance, filename):
    file_extension = os.path.splitext(filename)[1].lstrip('.')
    current_datetime = datetime.now().strftime('%Y%m%d%H%M%S')
    target_dir = f'profile_images/{instance.user.pk}'
    file_dir = os.path.join(settings.MEDIA_ROOT, target_dir)
    if not os.path.isdir(file_dir):
        os.makedirs(file_dir, 0o777)
    return os.path.join(target_dir, f'{current_datetime}.{file_extension}')



class Access(models.Model):
    name = models.CharField(max_length=50)
    
    class Meta:
        db_table = 'User_Access'

class Role(models.Model):
    name = models.CharField(max_length=50)
    access_ids = models.TextField(blank=True)
    created_on = models.DateTimeField(auto_now_add=True)
    active=models.BooleanField(default=False)
    
    class Meta:
        db_table = 'role'
    
    
    def set_access_ids(self, id_list):
        # Convert list to string
        self.ids = ','.join(str(id) for id in id_list)

    def get_access_ids(self):
        # Convert string back to list
        return self.ids.split(',')

    def __str__(self):
        return self.name

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(email, password, **extra_fields)

class Users(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True)
    role = models.ForeignKey(Role, on_delete=models.CASCADE, null=True, blank=True)
    cnic = models.CharField(max_length=13, null=True, blank=True)
    age = models.IntegerField(null=True, blank=True)
    gender = models.CharField(max_length=100, null=True, blank=True)
    hired_date = models.DateField(auto_now_add=True)
    hired_time = models.TimeField(auto_now_add=True)
    auth_key = models.CharField(max_length=512, null=True, blank=True)
    register_by = models.ForeignKey('self', on_delete=models.SET_NULL, null=True, blank=True)
    profile_image = models.FileField(upload_to='profile_images/', null=True, blank=True)
    status = models.CharField(max_length=100, null=True, blank=True)

    # Fields required by AbstractBaseUser
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    date_joined = models.DateTimeField(default=timezone.now)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def __str__(self):
        return self.email
    
    
    class Meta:
        db_table = 'Users'
        
        
        

    
    
    
class User_Attendance(models.Model):
    ATTENDENCE_STATUS = (
        ('present', 'Present'),
        ('absent', 'Absent'),
        ('leave', 'On Leave')
    )
    user = models.ForeignKey(Users,on_delete=models.CASCADE)
    date = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=20, choices=ATTENDENCE_STATUS, null=True, blank=True)
    updated_by = models.ForeignKey(Users, on_delete=models.CASCADE,related_name='attendance')
    latitude = models.FloatField()
    longitude = models.FloatField()
    address = models.CharField(max_length=155, null=True, blank=True)
    
    def __str__(self):
        return f'{self.user} and {self.status}'
    
    class Meta:
        db_table = 'User_Attendance'