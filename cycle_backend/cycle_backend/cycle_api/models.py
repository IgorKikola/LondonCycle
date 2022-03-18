from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from .managers import UserManager

import requests
import csv

class Place(models.Model):
    id = models.TextField(primary_key='True')
    name = models.TextField()
    lat = models.FloatField()
    lon = models.FloatField()

    @classmethod
    def create(cls, id, name, lat, lon):
        place = cls(id=id, name=name, lat=lat, lon=lon)
        return place

    @classmethod
    def get_all_bikepoints(cls):
        response = requests.get('https://api.tfl.gov.uk/BikePoint/')
        bikepoints = response.json()
        for bikepoint in bikepoints:
            place = Place.create(bikepoint['id'],
                                bikepoint['commonName'],
                                bikepoint['lat'],
                                bikepoint['lon'])
            place.save()

    @classmethod
    def get_all_landmarks(cls):
        with open('landmarks.csv', 'r') as file:
            reader = csv.reader(file)
            for landmark in reader:
                place = Place.create(landmark[0],
                                     landmark[1],
                                     landmark[2],
                                     landmark[3])
                place.save()

""" Custom User model """
class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(unique=True, blank=False)
    first_name = models.CharField(max_length=50, blank=False)
    last_name = models.CharField(max_length=50, blank=False)
    created_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)

    objects = UserManager()

    """ Field which to identify the user by """
    USERNAME_FIELD = 'email'
    
    """ Field taht cannot be blank """
    REQUIRED_FIELDS = ['first_name', 'last_name']

    def __str__(self):
        return self.email

    def full_name(self):
        return f'{self.first_name} {self.last_name}'

    class Meta:
        """Model options."""
        ordering = ['-created_at']
