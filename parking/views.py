from django.forms import model_to_dict
from django.shortcuts import render
from authentication.permissions import (IsAdmin,IsUser)
from .serializers import CreateParkingPlazaSerializer,CreateParkingVehicleCheckInSerializer
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from .models import ParkingVehicle, Vehicle,ParkingPlaza
from rest_framework import generics, permissions
from datetime import datetime   


# Create your views here.
class CreateParkingPlazaView(generics.CreateAPIView):
    permission_classes = [IsAdmin]
    serializer_class = CreateParkingPlazaSerializer
    
    
class GetParkingPlazaView(APIView):
    permission_classes = [IsUser]
    
    def get(self, request, *args, **kwargs):
        resp = {
            'status':True,
            'status_code':status.HTTP_200_OK,
            'message':"Parking Plaza List",
            'data':list(map(lambda x:{
                'id':x.pk,
                'name':x.name,
                'address':x.address,
                'area':x.area,
                'latitude':x.latitude,
                'longitude':x.longitude,
                # 'register_by':model_to_dict(x.register_by),
                'register_date':x.register_date,
                'register_time':x.register_time,
                'status':x.status,
                },
            ParkingPlaza.objects.all()))}
        return Response(resp)
        
    
    
class ParkingVehicleCheckInView(generics.CreateAPIView):
    permission_classes = [IsUser]
    serializer_class = CreateParkingVehicleCheckInSerializer
    
    def get(self, request, *args, **kwargs):
        resp = {
            'status':True,
            'status_code':status.HTTP_200_OK,
            'message':"Check In List",
            'data':list(map(lambda x:{
                'id':x.pk,
                'registration_number':x.registration_number,
                'vehicle_type':x.vehicle_type,
                'vehicle_model':x.vehicle_model,
                'check_in_date':x.check_in_date,
                'check_in_time':x.check_in_time,
                'check_in_plaza':model_to_dict(x.check_in_plaza),
                'check_in_by':x.check_in_by.email,
                },
        ParkingVehicle.objects.filter(check_out_date = None,check_out_time = None,check_out_by = None)))}
        return Response(resp)
    
    
class ParkingVehicleCheckOutView(APIView):
    permission_classes = [IsUser]
    
    def post(self, request, *args, **kwargs):
        id = request.POST.get('id',None)
        if id is None:
            return Response(
                {
                    'status':False,
                    'status_code':status.HTTP_400_BAD_REQUEST,
                    'message':'id is required',
                    'data':{},
                }
            )
        else:
            try:
                parking_vehicle = ParkingVehicle.objects.get(id=id)
                parking_vehicle.check_out_by = request.user
                parking_vehicle.check_out_date = datetime.date()
                parking_vehicle.check_out_time = datetime.time()
                parking_vehicle.save()
                return Response(
                {
                    'status':True,
                    'status_code':status.HTTP_200_OK,
                    'message':'Check out successfully',
                    'data':{},
                }
            )
            except:
                return Response(
                {
                    'status':False,
                    'status_code':status.HTTP_404_NOT_FOUND,
                    'message':'Parking Vehicle not found',
                    'data':{},
                }
            )
    
    
    
    
    
class GetVehicleTypeView(APIView):
    permission_classes = [IsAdmin]
    
    def get(self, request):
        queryset = Vehicle.objects.values('vehicle_type').distinct()
        unique_vehicle_types = [{'label': item['vehicle_type']} for item in queryset]
        resp = {
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'All Vehicle Model Type',
            'data': unique_vehicle_types
        }
        return Response(resp)
    
    
class GetVehicleModelbyTypeView(APIView):
    permission_classes = [IsAdmin]
    
    def get(self, request):
        vehicle_type_name = request.GET.get('vehicle_type',None)
        if vehicle_type_name is None:
            return Response({
             'status': False,
             'status_code': status.HTTP_400_BAD_REQUEST,
             'message': 'Please provide vehicle_type',
             'data': []
            })
        else:
            vehicles_qs = Vehicle.objects.filter(vehicle_type = vehicle_type_name).values('vehicle_model').distinct()
            if vehicles_qs.exists():
                unique_vehicle_types = [{'label': item['vehicle_model']} for item in vehicles_qs]
                resp = {
                'status': True,
                'status_code': status.HTTP_200_OK,
                'message': 'All Vehicle Model Type',
                'data': unique_vehicle_types
            }
            else:
                resp = {
                'status': True,
                'status_code': status.HTTP_404_NOT_FOUND,
                'message': 'No Vehicle Models of the given Vehicle Type',
                'data': []
            }

        return Response(resp)
        