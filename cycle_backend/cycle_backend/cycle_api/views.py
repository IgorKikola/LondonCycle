from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from cycle_backend.cycle_api.serializers import UserSerializer, PlaceSerializer, StopSerializer
from cycle_backend.cycle_api.models import Place, Stop


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

class StopViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows stops to be viewed or edited.
    """
    queryset = Stop.objects.all()
    serializer_class = StopSerializer