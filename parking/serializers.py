from django.forms import model_to_dict
from rest_framework.fields import empty
from authentication.models import Role, Users
from rest_framework import serializers, status
from django.db import transaction

from parking.admin import UserAllocationAdmin
from .models import ParkingPlaza, UserAllocation,Vehicle,ParkingVehicle



class CreateParkingPlazaSerializer(serializers.Serializer):
    status_code = serializers.IntegerField(read_only=True,default=status.HTTP_201_CREATED)
    status = serializers.BooleanField(read_only=True)
    message = serializers.CharField(read_only=True,default=None)
    data = serializers.DictField(read_only=True,default={})
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.resp = {'status' : True, 'message' : 'Parking Plaza Created Successfully','data' : None,'status_code' : status.HTTP_200_OK} 
        request = self.context["request"]
        self.request = request
        self.user = request.user
        self.fields["plaza_name"] = serializers.CharField(required = True,write_only=True)
        self.fields["latitude"] = serializers.FloatField(required = True,write_only=True)
        self.fields["longitude"] = serializers.FloatField(required = True,write_only=True)
        self.fields["address"] = serializers.CharField(required = True,write_only=True)

    
    def create(self, validated_data):
        plaza = ParkingPlaza.objects.create(
            name = validated_data["plaza_name"],
            address = validated_data["address"],
            latitude = validated_data["latitude"],
            longitude = validated_data["longitude"],
            register_by = self.user
        )
        self.resp['data'] = model_to_dict(plaza)
        return self.resp
    
    
    
    
class CreateParkingVehicleCheckInSerializer(serializers.Serializer):
    status_code = serializers.IntegerField(read_only=True,default=status.HTTP_201_CREATED)
    status = serializers.BooleanField(read_only=True)
    message = serializers.CharField(read_only=True,default=None)
    data = serializers.DictField(read_only=True,default={})
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.resp = {'status' : False, 'message' : None,'data' : None,'status_code' : status.HTTP_200_OK} 
        request = self.context["request"]
        self.request = request
        self.user = request.user
        self.fields["registration_number"] = serializers.CharField(required = True,write_only=True)
        # self.fields["vehicle_type"] = serializers.CharField(required = True,write_only=True)
        self.fields["vehicle_model"] = serializers.CharField(required = True,write_only=True)
        # self.fields["plaza_id"] = serializers.CharField(required = True,write_only=True)
        
        
    def validate(self, attrs):
        # plaza_id = attrs.get('plaza_id')
        errors = None
        attrs['valid'] = True
        
        # try:
        #     ParkingPlaza.objects.get(pk = plaza_id)
        # except:
        #     errors = 'Parking Plaza does not exist'
        #     attrs['valid'] = False
            
        if errors is not None:
            attrs['errors'] = errors
            attrs['valid'] = False
        
        return attrs
    
    def create(self, validated_data):
        if validated_data['valid'] == True:
            with transaction.atomic():
            
                user_allocation = UserAllocation.objects.filter(user = self.user).first()
                vehicle_obj = Vehicle.objects.filter(vehicle_model = validated_data["vehicle_model"]).first()
                vehicle = ParkingVehicle.objects.create(
                    registration_number = validated_data["registration_number"],
                    vehicle_type = vehicle_obj.vehicle_type,
                    vehicle_model = validated_data["vehicle_model"],
                    check_in_plaza = user_allocation.parking_plaza,
                    check_in_by = self.user
                )
                self.resp['status'] = True
                self.resp['message'] = 'Check in Succussfully'
                # self.resp['data'] = model_to_dict(vehicle)
        else:
            self.resp["status_code"] = status.HTTP_400_BAD_REQUEST
            self.resp["status"] = False
            self.resp["data"] = {}
            self.resp['message'] = validated_data.get('errors')
            
        return self.resp