from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from cycle_backend.cycle_api.serializers import UserSerializer, PlaceSerializer
from cycle_backend.cycle_api.models import Place
from django.http import HttpResponse
import requests
import csv


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
    return HttpResponse("Bikes")

def get_all_landmarks(request):
    with open('landmarks.csv', 'r') as file:
        reader = csv.reader(file)
        for landmark in reader:
            place = Place.create(landmark[0],
                                 landmark[1],
                                 landmark[2],
                                 landmark[3])
            place.save()
    return HttpResponse("Landmarks")
