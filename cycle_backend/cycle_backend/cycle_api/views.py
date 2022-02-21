from django.contrib.auth.models import User
from rest_framework import viewsets
from rest_framework import permissions
from cycle_backend.cycle_api.serializers import UserSerializer, PlaceSerializer
from cycle_backend.cycle_api.models import Place


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
    queryset = Place.get_all_bikepoints()
    serializer_class = PlaceSerializer
