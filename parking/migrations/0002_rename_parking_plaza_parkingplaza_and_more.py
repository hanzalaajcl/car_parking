# Generated by Django 4.2.6 on 2024-01-16 10:39

from django.conf import settings
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('parking', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Parking_Plaza',
            new_name='ParkingPlaza',
        ),
        migrations.RenameModel(
            old_name='Parking_Vehicle',
            new_name='ParkingVehicle',
        ),
        migrations.RenameModel(
            old_name='User_Allocation',
            new_name='UserAllocation',
        ),
        migrations.AlterModelTable(
            name='parkingplaza',
            table='ParkingPlaza',
        ),
        migrations.AlterModelTable(
            name='parkingvehicle',
            table='ParkingVehicle',
        ),
        migrations.AlterModelTable(
            name='userallocation',
            table='UserAllocation',
        ),
    ]
