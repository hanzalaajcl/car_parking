from django.contrib import admin
from .models import (ParkingPlaza,Vehicle,ParkingVehicle)

# Register your models here.


@admin.register(ParkingPlaza)
class ParkingPlazaAdmin(admin.ModelAdmin):
    list_display = ['name','address','area','latitude','longitute','register_by','register_date','register_time','status']
    
    
    
    
@admin.register(Vehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ['vehicle_type','vehicle_model','register_by','register_date','register_time','status','charges']
    
    
    
@admin.register(ParkingVehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ['vehicle_type','vehicle_model','registration_number','check_in_date','check_in_time','check_in_plaza','check_out_date','check_out_time'
                    ,'check_in_by','check_out_by']