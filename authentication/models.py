from django.db import models
from django.contrib.auth.models import  BaseUserManager
from django.utils import timezone
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
import os
from datetime import datetime
from django.conf import settings




def save_profile_image(instance, filename):
    print(instance,"================================")
    file_extension = os.path.splitext(filename)[1].lstrip('.')
    current_datetime = datetime.now().strftime('%Y%m%d%H%M%S')
    target_dir = f'profile_images/{instance.pk}'
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
        db_table = 'Role'
    
    
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
    first_name = models.CharField(max_length=125, null=True, blank=True)
    last_name = models.CharField(max_length=125, null=True, blank=True)
    cnic = models.CharField(max_length=17, null=True, blank=True)
    age = models.IntegerField(null=True, blank=True)
    gender = models.CharField(max_length=100, null=True, blank=True)
    hired_date = models.DateField(null=True, blank=True)
    hired_time = models.TimeField(null=True, blank=True)
    auth_key = models.CharField(max_length=512, null=True, blank=True)
    register_by = models.ForeignKey('self', on_delete=models.SET_NULL, null=True, blank=True)
    register_date = models.DateField(auto_now_add=True)
    register_time = models.TimeField(auto_now_add=True)
    profile_image = models.FileField(upload_to=save_profile_image, null=True, blank=True)
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
    
    def save(self, *args, **kwargs):
        if self.pk is None:
            print("----------------")
            # New user, set and hash the password
            self.set_password(self.password)
        super().save(*args, **kwargs)
        
    def get_main_image(self):
        profile_photo_path = None
        try:
            profile_photo_index = self.profile_image.path.split("/").index('uploads')
            profile_photo_path =  "/"+"/".join(self.profile_image.path.split("/")[profile_photo_index:])
        except Exception: pass
        return profile_photo_path
    
    
    class Meta:
        db_table = 'Users'
        
        
        

    
    
    
class UserAttendance(models.Model):
    ATTENDENCE_STATUS = (
        ('present', 'Present'),
        ('absent', 'Absent'),
        ('on_leave', 'On Leave')
    )
    user = models.ForeignKey(Users,on_delete=models.CASCADE,related_name='user_attendance')
    date = models.DateField(auto_now_add=True)
    status = models.CharField(max_length=20, choices=ATTENDENCE_STATUS,default = 'present')
    updated_by = models.ForeignKey(Users, on_delete=models.CASCADE,related_name='attendance')
    latitude = models.FloatField(null=True, blank=True)
    longitude = models.FloatField(null=True, blank=True)
    address = models.CharField(max_length=155, null=True, blank=True)
    
    def __str__(self):
        return f'{self.user} and {self.status}'
    
    class Meta:
        db_table = 'UserAttendance'