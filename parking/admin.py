from django.contrib import admin
from .models import (ParkingPlaza,Vehicle,ParkingVehicle,UserAllocation,GlobalConfiguration)

# Register your models here.


@admin.register(ParkingPlaza)
class ParkingPlazaAdmin(admin.ModelAdmin):
    list_display = ['name','address','area','latitude','longitude','register_by','register_date','register_time','status']
    
    
    
    
@admin.register(Vehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ['vehicle_type','vehicle_model','register_by','register_date','register_time','status','charges','vehicle_image']
    
    
    
@admin.register(ParkingVehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ['vehicle_type','vehicle_model','registration_number','check_in_date','check_in_time','check_in_plaza','check_out_date','check_out_time'
                    ,'check_in_by','check_out_by']
    
    
@admin.register(UserAllocation)
class UserAllocationAdmin(admin.ModelAdmin):
    list_display = ['user','parking_plaza','assign_date','assign_time','upload_date','upload_time','status']
    
    
@admin.register(GlobalConfiguration)
class GlobalConfigurationAdmin(admin.ModelAdmin):
    list_display = ['name','value']