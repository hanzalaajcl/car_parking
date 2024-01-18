from django.contrib import admin
from .models import (Users,Role,Access,UserAttendance)

# Register your models here.

@admin.register(Access)
class accessAdmin(admin.ModelAdmin):
    list_display = ['name']


@admin.register(Role)
class RoleAdmin(admin.ModelAdmin):
    list_display = ['name','access_ids','created_on','active']

@admin.register(Users)
class UsersAdmin(admin.ModelAdmin):
    list_display = ['email','role','cnic','age','gender','auth_key','profile_image','status']
    
    

@admin.register(UserAttendance)
class UserAttendanceAdmin(admin.ModelAdmin):
    list_display = ['user','date','status','updated_by','latitude','longitude','address']
