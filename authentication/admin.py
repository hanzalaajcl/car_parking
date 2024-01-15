from django.contrib import admin
from .models import (Users,Role,access,UserAllocation,UserAttendance)

# Register your models here.

@admin.register(access)
class accessAdmin(admin.ModelAdmin):
    list_display = ['name']


@admin.register(Role)
class RoleAdmin(admin.ModelAdmin):
    list_display = ['name','access_ids','created_on','active']

@admin.register(Users)
class UsersAdmin(admin.ModelAdmin):
    list_display = ['email','role','cnic','age','gender','auth_key','profile_image','status']
    
    
@admin.register(UserAllocation)
class UserAllocationAdmin(admin.ModelAdmin):
    list_display = ['user','parking_plaza','assign_date','assign_time','upload_date','upload_time','status']
    
    
    
@admin.register(UserAttendance)
class UserAttendanceAdmin(admin.ModelAdmin):
    list_display = ['user','date','attendence_status','updated_by','latitude','longitute','address']
