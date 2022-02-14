from django.db import models

class Place(models.Model):
    id = models.TextField(primary_key='True')
    name = models.TextField()
    lat = models.FloatField()
    lon = models.FloatField()

    @classmethod
    def create(cls, id, name, lat, lon):
        place = cls(id=id, name=name, lat=lat, lon=lon)
        return place
