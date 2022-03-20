from django.db import models
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

class Stop(models.Model):
    name = models.TextField()
    lat = models.FloatField()
    lon = models.FloatField()
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created']