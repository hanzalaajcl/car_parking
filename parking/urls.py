from django.urls import path, include
from .views import GetVehicleModelbyTypeView,CreateParkingPlazaView\
    ,GetVehicleTypeView,ParkingVehicleCheckInView\
    ,GetParkingPlazaView,ParkingVehicleCheckOutView\
    ,GetVehicleModel,DashboardViews,CardsCountAndRecentActivity\
    ,GetParkingVehicleCount

urlpatterns = [
    path('create_plaza/', CreateParkingPlazaView.as_view(),name='create_plaza'),
    # path('get_vehicle_model/', GetVehicleModelbyTypeView.as_view(),name='get_vehicle_type'),
    path('get_vehicle_types/', GetVehicleTypeView.as_view(),name='get_vehicle_types'),
    path('check_in/', ParkingVehicleCheckInView.as_view(),name='check_in'),
    path('get_plaza/', GetParkingPlazaView.as_view(),name='get_plaza'),
    path('check_out/', ParkingVehicleCheckOutView.as_view(),name='check_out'),


    path('get_vehicle_model/', GetVehicleModel.as_view(),name='get_vehicle_model'),
    
    
    path('get_dashboard/', DashboardViews.as_view(),name='get_dashboard'),
    path('get_counts_card/', CardsCountAndRecentActivity.as_view(),name='get_counts_card'),
    
    path('get_user_parking_list/', GetParkingVehicleCount.as_view(),name='get_user_parking_list'),
]