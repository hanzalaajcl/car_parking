# Generated by Django 4.2.6 on 2024-01-18 06:29

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('parking', '0004_rename_parking_plaza_log_parkingplazalog_and_more'),
    ]

    operations = [
        migrations.AlterModelTable(
            name='globalconfiguration',
            table='GlobalConfiguration',
        ),
        migrations.AlterModelTable(
            name='vehicle',
            table='Vehicle',
        ),
    ]
