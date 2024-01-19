from django.forms import model_to_dict
from django.shortcuts import render
from authentication.permissions import (IsAdmin,IsUser)
from .serializers import CreateParkingPlazaSerializer,CreateParkingVehicleCheckInSerializer
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from .models import ParkingVehicle, Vehicle,ParkingPlaza
from rest_framework import generics, permissions
from datetime import datetime,date


# Create your views here.    
    
class CreateParkingPlazaView(APIView):
    permission_classes = [IsAdmin]
    
    def post(self, request, *args, **kwargs):
        serializer = CreateParkingPlazaSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            response_data = serializer.save()
            # Use the status code from the serializer's response
            return Response(response_data, status=response_data.get('status_code', status.HTTP_200_OK))
        else:
            # Handle invalid serializer with a 400 status code
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
    
class GetParkingPlazaView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    
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
        
    
    
    
class ParkingVehicleCheckInView(APIView):
    permission_classes = [IsUser]
    def post(self, request, *args, **kwargs):
        serializer = CreateParkingVehicleCheckInSerializer(data=request.data, context={'request': request})
        if serializer.is_valid():
            response_data = serializer.save()
            # Use the status code from the serializer's response
            return Response(response_data, status=response_data.get('status_code', status.HTTP_200_OK))
        else:
            # Handle invalid serializer with a 400 status code
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    
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
        return Response(resp,status=resp['status_code'])


    
class ParkingVehicleCheckOutView(APIView):
    permission_classes = [IsUser]
    
    def post(self, request, *args, **kwargs):
        # id = request.POST.get('id',None)
        id = request.data.get('id',None)
        if id is None:
            return Response(
                {
                    'status':False,
                    'status_code':status.HTTP_400_BAD_REQUEST,
                    'message':'id is required',
                    'data':{},
                },status=status.HTTP_400_BAD_REQUEST
            )
        else:
            try:
                parking_vehicle = ParkingVehicle.objects.get(id=id)
                parking_vehicle.check_out_by = request.user
                parking_vehicle.check_out_date = date.today()  # Use date.today() for the current date
                parking_vehicle.check_out_time = datetime.now().time()  # Use datetime.now().time() for the current time
                parking_vehicle.save()
                return Response(
                {
                    'status':True,
                    'status_code':status.HTTP_200_OK,
                    'message':'Check out successfully',
                    'data':{},
                },status=status.HTTP_200_OK
            )
            except:
                return Response(
                {
                    'status':False,
                    'status_code':status.HTTP_404_NOT_FOUND,
                    'message':'Parking Vehicle not found',
                    'data':{},
                },status=status.HTTP_404_NOT_FOUND
            )
    
    
    
    
    
class GetVehicleTypeView(APIView):
    permission_classes = [IsAdmin]
    
    def get(self, request):
        queryset = Vehicle.objects.values('vehicle_type').distinct()
        unique_vehicle_types = [{'label': item['vehicle_type'],'value':item['vehicle_type']} for item in queryset]
        resp = {
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'All Vehicle Model Type',
            'data': unique_vehicle_types
        }
        return Response(resp,status=resp['status_code'])
    
    
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
            },status=status.HTTP_400_BAD_REQUEST)
        else:
            vehicles_qs = Vehicle.objects.filter(vehicle_type = vehicle_type_name).values('vehicle_model').distinct()
            if vehicles_qs.exists():
                unique_vehicle_types = [{'label': item['vehicle_model'],'value':item['vehicle_model']} for item in vehicles_qs]
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

        return Response(resp,status=resp['status_code'])
        
        
        
        


class GetVehicleModel(APIView):
    # permission_classes = [IsAdmin]
    permission_classes = [permissions.AllowAny]
    
    def get(self, request):
        queryset = Vehicle.objects.all()
        unique_vehicle_types = {}

        for vehicle in queryset:
            key = (vehicle.vehicle_model, vehicle.vehicle_image.url if vehicle.vehicle_image else None)
            if key not in unique_vehicle_types:
                unique_vehicle_types[key] = {
                    'vehicle_model': vehicle.vehicle_model,
                    'vehicle_image': vehicle.vehicle_image.url if vehicle.vehicle_image else None
                }

        unique_vehicle_types = list(unique_vehicle_types.values())
        resp = {
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'All Vehicle Model',
            'data': unique_vehicle_types
        }
        return Response(resp,status=resp['status_code'])