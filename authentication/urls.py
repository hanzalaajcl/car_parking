from django.urls import path, include
from .views import (
    # UserRegisterView,
                    UserLoginView,
                    UserRegisterView,
                    GetProfileView,
                    ChangePasswordVew,
                    UserAttendence,
                    GetUserAttendanceStatus,
                    AdminSignupRegisterView
                    )
from django_rest_passwordreset.views import (ResetPasswordConfirm,ResetPasswordRequestToken)
urlpatterns = [
    # path('signup/', UserRegisterView.as_view(),name='signup'),
    path('signin/', UserLoginView.as_view(),name='signin'),
    path('confirm/', ResetPasswordConfirm.as_view(),name='reset-password-confirm'),
    path('password_reset/request/', ResetPasswordRequestToken.as_view(), name='reset-password-request'),
    path('user_register/', UserRegisterView.as_view(), name='user_register'),
    path('users_details/', GetProfileView.as_view(), name='users_details'),
    path('passwor_change/', ChangePasswordVew.as_view(), name='passwor_change'),
    path('create_user_attendence/', UserAttendence.as_view(), name='create_user_attendence'),
    path('get_user_attendence/', GetUserAttendanceStatus.as_view(), name='get_user_attendence'),
    
    
    path('admin_signup/', AdminSignupRegisterView.as_view(), name='admin_signup'),
]