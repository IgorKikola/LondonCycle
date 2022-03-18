from rest_framework import viewsets
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.authtoken.models import Token

from .serializers import PlaceSerializer, UserSerializer, SignupSerializer
from .models import Place, User

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

# Signup view
@api_view(['POST'])
def signup_view(request):
    serializer = SignupSerializer(data=request.data)
    response_data = {}
    if serializer.is_valid():
        user = serializer.save()
        token = Token.objects.get(user=user).key

        response_data['response'] = "Signup was successful"
        response_data['first_name'] = user.first_name
        response_data['last_name'] = user.last_name
        response_data['email'] = user.email
        response_data['token'] = token
    else:
        response_data = serializer.errors
    return Response(response_data)
        