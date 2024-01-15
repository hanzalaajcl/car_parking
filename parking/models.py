from django.db import models
from authentication.models import (Users)


# Create your models here.
class ParkingPlaza(models.Model):
    name = models.CharField(max_length=50, blank=True,null = True)
    address = models.CharField(max_length=50, blank=True,null = True)
    area = models.FloatField(decimal_places=15, max_digits=53)
    latitude = models.FloatField(decimal_places=15, max_digits=53)
    longitute = models.FloatField(decimal_places=15, max_digits=53)
    register_by = models.ForeignKey(Users,on_delete=models.CASCADE)
    register_date = models.DateField(auto_now_add=True)
    register_time = models.TimeField(auto_now_add=True)
    status = models.BooleanField(default=False)
    
    def __str__(self):
        return self.name
    
    
    class Meta:
        db_table = 'parkingPlaza'
    
    
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
        db_table = 'vehicle'
    
    
class ParkingVehicle(models.Model):
    registration_number = models.CharField(max_length=256)
    vehicle_type = models.CharField(max_length = 155)
    vehicle_model = models.CharField(max_length = 155)
    check_in_date = models.DateField(auto_now_add=True)
    check_in_time = models.TimeField(auto_now_add=True)
    check_in_plaza = models.ForeignKey(ParkingPlaza,on_delete = models.CASCADE)
    check_out_date = models.DateField(auto_now_add=True)
    check_out_time = models.TimeField(auto_now_add=True)
    check_in_by = models.ForeignKey(Users,on_delete=models.CASCADE)
    check_out_by = models.ForeignKey(Users,on_delete=models.CASCADE,blank = True,null= True)
    
    def __str__(self):
        return self.registration_number
    
    class Meta:
        db_table = 'parkingVehicle'