from django.db import models
from authentication.models import (Users)


# Create your models here.
class ParkingPlaza(models.Model):
    name = models.CharField(max_length=50, blank=True,null = True)
    address = models.CharField(max_length=50, blank=True,null = True)
    area = models.FloatField(blank=True,null = True)
    latitude = models.FloatField()
    longitude = models.FloatField()
    register_by = models.ForeignKey(Users,on_delete=models.CASCADE)
    register_date = models.DateField(auto_now_add=True)
    register_time = models.TimeField(auto_now_add=True)
    status = models.BooleanField(default=False)
    
    def __str__(self):
        return self.name
    
    
    class Meta:
        db_table = 'ParkingPlaza'
    
    
class Vehicle(models.Model):
    vehicle_type = models.CharField(max_length = 155)
    vehicle_model = models.CharField(max_length = 155)
    register_by = models.ForeignKey(Users,on_delete=models.CASCADE)
    register_date = models.DateField(auto_now_add=True)
    register_time = models.TimeField(auto_now_add=True)
    status = models.BooleanField(default=False)
    charges = models.FloatField()
    
    def __str__(self):
        return f'vehicle_model {self.vehicle_model} is registered by {self.register_by}'
    
    
    class Meta:
        db_table = 'Vehicle'
    
    
class ParkingVehicle(models.Model):
    registration_number = models.CharField(max_length=256)
    vehicle_type = models.CharField(max_length = 155)
    vehicle_model = models.CharField(max_length = 155)
    check_in_date = models.DateField(auto_now_add=True)
    check_in_time = models.TimeField(auto_now_add=True)
    check_in_plaza = models.ForeignKey(ParkingPlaza,on_delete = models.CASCADE)
    check_out_date = models.DateField(blank = True,null= True)
    check_out_time = models.TimeField(blank = True,null= True)
    check_in_by = models.ForeignKey(Users,on_delete=models.CASCADE)
    check_out_by = models.ForeignKey(Users,on_delete=models.CASCADE,blank = True,null= True,related_name= "user_who_checked_out")
    
    def __str__(self):
        return self.registration_number
    
    class Meta:
        db_table = 'ParkingVehicle'
        
        
        
class UserAllocation(models.Model):
    user = models.ForeignKey(Users,on_delete=models.CASCADE)
    assigned_by = models.ForeignKey(Users,on_delete=models.CASCADE,related_name='user_who_assigned')
    parking_plaza = models.ForeignKey(ParkingPlaza,on_delete=models.CASCADE)
    assign_date = models.DateField(auto_now_add=True)
    assign_time = models.TimeField(auto_now_add=True)
    upload_date = models.DateField(auto_now_add=True)
    upload_time = models.TimeField(auto_now_add=True)
    status = models.BooleanField(default=False)
    
    
    def __str__(self):
        return f'{self.user} and {self.parking_plaza}'
    
    
    class Meta:
        db_table = 'UserAllocation'
        
        
        
        
        
class ParkingPlazaLog(models.Model):
    name = models.CharField(max_length=50, blank=True, null=True)
    address = models.CharField(max_length=50, blank=True, null=True)
    area = models.FloatField()
    latitude = models.FloatField()
    longitude = models.FloatField()
    register_by = models.ForeignKey(Users, on_delete=models.CASCADE)
    register_date = models.DateField(auto_now_add=True)
    register_time = models.TimeField(auto_now_add=True)
    status = models.BooleanField(default=False)
    log_timestamp = models.DateTimeField(auto_now_add=True)  # Timestamp for logging
    
    def __str__(self):
        return self.name

    class Meta:
        db_table = 'ParkingPlazaLog'
        
        
        
        
class GlobalConfiguration(models.Model):
    name = models.CharField(max_length=36)
    value = models.CharField(max_length=128)

    def __str__(self):
        return '%s' % self.name

    class Meta:
        db_table = 'GlobalConfiguration'