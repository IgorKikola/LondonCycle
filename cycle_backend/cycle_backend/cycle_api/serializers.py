from django.contrib.auth.models import User
from cycle_backend.cycle_api.models import Place
from rest_framework import serializers


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email']

class PlaceSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Place
        fields = ['id', 'name', 'lat', 'lon']
