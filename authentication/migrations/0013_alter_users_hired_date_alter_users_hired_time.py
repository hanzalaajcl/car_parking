# Generated by Django 4.2.6 on 2024-01-22 13:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('authentication', '0012_alter_userattendance_latitude_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='users',
            name='hired_date',
            field=models.DateField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='users',
            name='hired_time',
            field=models.TimeField(blank=True, null=True),
        ),
    ]
