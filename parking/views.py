from django.forms import model_to_dict
from django.shortcuts import render
from authentication.models import Users
from authentication.permissions import (IsAdmin,IsUser)
from .serializers import CreateParkingPlazaSerializer,CreateParkingVehicleCheckInSerializer
from rest_framework.views import APIView
from rest_framework import status
from rest_framework.response import Response
from .models import ParkingVehicle, UserAllocation, Vehicle,ParkingPlaza
from rest_framework import generics, permissions
from datetime import datetime,date
from .utils import convert_to_specific_format

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
    
    
    
    
class GetParkingVehicleCount(APIView):
    # permission_classes = [IsAdmin]
    permission_classes = [permissions.AllowAny]
    
    
    def get(self,request):
        date = self.request.GET.get('date',None)
        user_allocations = UserAllocation.objects.all()
        
        all_data = []
        if date is not None:
            result_date = convert_to_specific_format(date)
            if result_date['status'] == False:
                return Response({
                    'status': result_date['status'],
                    'status_code':status.HTTP_400_BAD_REQUEST,
                    'message':result_date['message'],
                    'data': {}
                },status=status.HTTP_400_BAD_REQUEST)
            else:
                for user_allocation in user_allocations:
                    parking_vehicles = ParkingVehicle.objects.filter(check_in_plaza = user_allocation.parking_plaza,check_in_date = result_date['date'])
                    parking_check_in_count = parking_vehicles.filter(check_in_by = user_allocation.user,check_out_by = None).count()
                    parking_check_out_count = parking_vehicles.filter(check_in_by = user_allocation.user,check_out_by = user_allocation.user).count()
                    data = {
                        'user_id': user_allocation.user.pk,
                        'first_name': user_allocation.user.first_name,
                        'last_name': user_allocation.user.last_name,
                        'email': user_allocation.user.email,
                        'parking_plaza_id': parking_vehicles.first().check_in_plaza.pk if parking_vehicles.exists() and parking_vehicles.first() else None,
                        'parking_plaza_name': parking_vehicles.first().check_in_plaza.name if parking_vehicles.exists() and parking_vehicles.first() else None,
                        'check_in_plaza_count': parking_check_in_count,
                        'check_out_plaza_count': parking_check_out_count,
                    }
                    all_data.append(data)
        else:
            for user_allocation in user_allocations:
                parking_vehicles = ParkingVehicle.objects.filter(check_in_plaza = user_allocation.parking_plaza)
                parking_check_in_count = parking_vehicles.filter(check_in_by = user_allocation.user,check_out_by = None).count()
                parking_check_out_count = parking_vehicles.filter(check_in_by = user_allocation.user,check_out_by = user_allocation.user).count()
                data = {
                    'user_id': user_allocation.user.pk,
                    'first_name': user_allocation.user.first_name,
                    'last_name': user_allocation.user.last_name,
                    'email': user_allocation.user.email,
                    'parking_plaza_id': parking_vehicles.first().check_in_plaza.pk if parking_vehicles.exists() and parking_vehicles.first() else None,
                    'parking_plaza_name': parking_vehicles.first().check_in_plaza.name if parking_vehicles.exists() and parking_vehicles.first() else None,
                    'check_in_plaza_count': parking_check_in_count,
                    'check_out_plaza_count': parking_check_out_count,
                }
                all_data.append(data)
                
        return Response({
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'Parking Vehicle Count',
            'data': all_data
        },status=status.HTTP_200_OK )
                  
            
            
    
class DashboardViews(APIView):
    permission_classes = [permissions.AllowAny]

    def get(self, request):
        resp = {
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'Dashboard Details',
            'data': {
                'parkingLotsTrends': {'labels': [], 'datasets': []},
                'userPerformanceTrends': {'labels': [], 'datasets': []},
            },
        }

        plaza_names = []
        parked_counts = []
        # colors = ['(opacity = 1) => #3333', '(opacity = 1) => #addd', '(opacity = 1) => #FAFA', '(opacity = 1) => #DAA']
        colors =  [
                "#3333",
                "#addd",
                "#FAFA",
                "#DAA"
            ]
        users_name = []
        plaza_of_users = []

        date = request.GET.get('date', None)
        plazas = ParkingPlaza.objects.all()
        users = Users.objects.filter(role__name = 'user')

        if date is None:
            current_date = datetime.now().date()
            current_date_str = current_date.strftime('%Y-%m-%d')
        else:
            date = convert_to_specific_format(date)
            if date['status'] == False:
                return Response({
                    'status': date['status'],
                    'status_code': status.HTTP_400_BAD_REQUEST,
                    'message': date['message'],
                    'data': {},
                }, status=status.HTTP_400_BAD_REQUEST)

            current_date_str = date['date']  # Use the formatted date

        for plaza in plazas:
            parking_vehicles = ParkingVehicle.objects.filter(check_in_date=current_date_str, check_in_plaza=plaza)
            plaza_names.append(plaza.name)
            parked_counts.append(parking_vehicles.count())

        resp['data']['parkingLotsTrends']['labels'] = plaza_names
        resp['data']['parkingLotsTrends']['datasets'] = [
            {
                'data': parked_counts,
                'colors': colors,
            }
        ]
        
        for user in users:
            parking_vehicles_by_user = ParkingVehicle.objects.filter(check_in_date=current_date_str, check_in_by=user)
            users_name.append(user.first_name)
            plaza_of_users.append(parking_vehicles_by_user.count())
            
        resp['data']['userPerformanceTrends']['labels'] = users_name
        resp['data']['userPerformanceTrends']['datasets'] = [
            {
                'data': plaza_of_users,
                'colors': colors,
            }
        ]
            
        return Response(resp, status=status.HTTP_200_OK)
    





class CardsCountAndRecentActivity(APIView):
    permission_classes = [permissions.AllowAny]
    
    def get(self, request, *args, **kwargs):
        resp = {
            'status': True,
            'status_code': status.HTTP_200_OK,
            'message': 'All cards count',
            'data': {'counts': {}, 'recent_activity': []},
        }

        parking_qs = ParkingVehicle.objects.all()

        resp['data']['counts']['users'] = UserAllocation.objects.all().count()
        resp['data']['counts']['vechicles_type'] = Vehicle.objects.values('vehicle_type').distinct().count()
        resp['data']['counts']['parking_plaza'] = ParkingPlaza.objects.all().count()
        resp['data']['counts']['registration_no'] = parking_qs.values('registration_number').distinct().count()
        resp['data']['counts']['no_of_parked_vehicles'] = parking_qs.filter(check_out_date__isnull=False).count()
        
        # Recent Activity
        activity = []

        recently_checkedin_vehicle = parking_qs.filter(check_out_date__isnull=True).order_by('-check_in_date', '-check_in_time')[:5]
        recently_checkedout_vehicle = parking_qs.filter(check_out_date__isnull=False).order_by('-check_out_date', '-check_out_time')[:5]

        all_recent_checkin_events = list(recently_checkedin_vehicle)
        all_recent_checkout_events = list(recently_checkedout_vehicle)

        # Combine check-in and check-out events, preserving order
        all_recent_vehicle_events = sorted(
            all_recent_checkin_events + all_recent_checkout_events,
            key=lambda event: getattr(event, 'check_in_date' if event.check_out_date is None else 'check_out_date'),
            reverse=True
        )

        for event in all_recent_vehicle_events:
            if event.check_out_date is not None:
                heading = f'{event.check_out_by.first_name} Check Out at {event.check_in_plaza.name}'
                text = f'{event.check_out_by.first_name} Check Out upon leaving from {event.check_in_plaza.name}'
                date_time = f'check out date and time is {str(event.check_out_date), str(event.check_out_time)}'
            else:
                heading = f'{event.check_in_by.first_name} Check In at {event.check_in_plaza.name}'
                text = f'{event.check_in_by.first_name} Check In upon arriving at {event.check_in_plaza.name}'
                date_time = f'check in date and time is {str(event.check_in_date), str(event.check_in_time)}'
            
            recent_data = {
                'heading': heading,
                'text': text,
                'date_time': date_time,
            }
            activity.append(recent_data)
        
        resp['data']['recent_activity'] = activity
        return Response(resp, status=status.HTTP_200_OK)

