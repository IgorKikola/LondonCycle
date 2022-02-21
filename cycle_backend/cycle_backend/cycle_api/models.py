from django.db import models
import requests

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
    def get_all_bikepoints(request):
        Place.objects.all().delete()
        response = requests.get('https://api.tfl.gov.uk/BikePoint/')
        bikepoints = response.json()
        for bikepoint in bikepoints:
            place = Place.create(bikepoint['id'],
                                bikepoint['commonName'],
                                bikepoint['lat'],
                                bikepoint['lon'])
            place.save()
        return Place.objects.all()
