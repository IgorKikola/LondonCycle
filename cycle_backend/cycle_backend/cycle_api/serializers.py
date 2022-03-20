from django.contrib.auth.models import User
from cycle_backend.cycle_api.models import Place, Stop
from rest_framework import serializers
from . import views


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email']

class PlaceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Place
        fields = ['id', 'name', 'lat', 'lon']

class StopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Stop
        fields = ['id', 'name', 'lat', 'lon', 'created']