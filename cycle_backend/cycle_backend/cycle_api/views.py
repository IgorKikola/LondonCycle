from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from cycle_backend.cycle_api.serializers import UserSerializer, PlaceSerializer
from cycle_backend.cycle_api.models import Place
from rest_framework.decorators import api_view
from rest_framework.response import Response
from jsonmerge import Merger
import requests

@api_view()
def get_route(request, fromPlace, toPlace):
    return Response(requests.get(f'https://api.tfl.gov.uk/Journey/JourneyResults/{fromPlace}/to/{toPlace}?/mode=cycle'))

@api_view()
def get_route_single_stop(request, fromPlace, firstStop, toPlace):
    return Response(requests.get(f'https://api.tfl.gov.uk/Journey/JourneyResults/{fromPlace}/to/{toPlace}?via={firstStop}&mode=cycle'))

@api_view()
def get_route_multiple_stop(request, fromPlace, stringOfStops, toPlace):
    schema = {
                "properties": {
                        "mergeStrategy": "append"     
                 }
             }
    merger=Merger(schema)
    listStops = stringOfStops.split(";")
    i = 0
    base = Response(requests.get(f'https://api.tfl.gov.uk/Journey/JourneyResults/{fromPlace}/to/{listStops[i]}?/mode=cycle'))
    while i+1 <= len(listStops):
        currentStop= listStops[i]
        nextStop= listStops[i+i]
        result= merger.merge(base,Response(requests.get(f'https://api.tfl.gov.uk/Journey/JourneyResults/{currentStop}/to/{nextStop}?/mode=cycle')))
        i+=1
    end= Response(requests.get(f'https://api.tfl.gov.uk/Journey/JourneyResults/{nextStop}/to/{toPlace}?/mode=cycle'))
    result=merger.merge(result,end)
    return result

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
