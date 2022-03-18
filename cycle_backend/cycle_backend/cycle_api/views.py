from rest_framework import viewsets
from rest_framework.decorators import api_view
from .serializers import PlaceSerializer, UserSerializer, SignupSerializer
from rest_framework.response import Response
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
        response_data['response'] = "Signup was successful"
        response_data['email'] = user.email
    else:
        response_data = serializer.errors
    return Response(response_data)
        