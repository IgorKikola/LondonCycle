from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from cycle_backend.cycle_api.serializers import UserSerializer
from cycle_backend.cycle_api.models import Place
from django.http import HttpResponse
import requests


class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAuthenticated]

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
