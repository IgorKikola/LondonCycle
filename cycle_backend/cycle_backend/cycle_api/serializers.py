from cycle_backend.cycle_api.models import Place
from rest_framework import serializers
from . import views

class PlaceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Place
        fields = ['id', 'name', 'lat', 'lon']
