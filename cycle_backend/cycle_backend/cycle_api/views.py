from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from cycle_backend.cycle_api.serializers import UserSerializer, PlaceSerializer
from cycle_backend.cycle_api.models import Place
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .helpers import get_n_closest_places, bikepoint_get_property
import requests

@api_view()
def get_n_closest_bikepoints(request, n, lat, lon):
    bikepoints = Place.objects.filter(id__startswith='BikePoints')
    closest_places = get_n_closest_places(n, bikepoints, float(lat), float(lon))
    serializer = PlaceSerializer(closest_places, many=True)
    return Response(serializer.data)

@api_view()
def get_n_closest_landmarks(request, n, lat, lon):
    landmarks = Place.objects.filter(id__startswith='Landmark')
    closest_places = get_n_closest_places(n, landmarks, float(lat), float(lon))
    serializer = PlaceSerializer(closest_places, many=True)
    return Response(serializer.data)

@api_view()
def bikepoint_number_of_bikes(request, bikepoint_id):
    return Response({'Number of bikes' : bikepoint_get_property(bikepoint_id, 'NbBikes')})

class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]

class PlaceViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows places to be viewed or edited.
    """
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer

class BikePointViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows bikepoints to be viewed or edited.
    """
    queryset = Place.objects.filter(id__startswith='BikePoints')
    serializer_class = PlaceSerializer

class LandmarkViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows landmarks to be viewed or edited.
    """
    queryset = Place.objects.filter(id__startswith='Landmark')
    serializer_class = PlaceSerializer
