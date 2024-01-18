from rest_framework import permissions
from .models import Users

class IsUser(permissions.BasePermission):
    message = {'status':False,'status_code':403,'message':'Only users are allowed to perform this action.','data':{}}
    def has_permission(self, request, view):
        return request.user.is_authenticated \
            and \
                Users.objects.filter(pk=request.user.pk, role__name="user").exists()
    
class IsAdmin(permissions.BasePermission):
    message = {'status':False,'status_code':403,'message':'Only admin users are allowed to perform this action. ','data':{}}
    def has_permission(self, request, view):
        return request.user.is_authenticated and \
            request.user.is_superuser