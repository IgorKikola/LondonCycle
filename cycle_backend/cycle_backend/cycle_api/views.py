from rest_framework import viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated
from django.utils.decorators import method_decorator

from .serializers import PlaceSerializer, SignupSerializer, UserSerializer
from .models import Place

from geopy import distance
from queue import PriorityQueue

from rest_framework import permissions
from .helpers import get_n_closest_places, bikepoint_get_property, get_places_by_distance
import requests


@api_view()
@permission_classes([])
def get_n_closest_bikepoints(request, n, lat, lon):
    """
    Retrieve the n closest bikepoints from the given location.
    """
    bikepoints = Place.objects.filter(id__startswith='BikePoints')
    closest_places = get_n_closest_places(n, bikepoints, float(lat), float(lon))
    serializer = PlaceSerializer(closest_places, many=True)
    return Response(serializer.data)

@api_view()
@permission_classes([])
def get_n_closest_landmarks(request, n, lat, lon):
    """
    Retrieve the n closest bikepoints from the given location.
    """
    landmarks = Place.objects.filter(id__startswith='Landmark')
    closest_places = get_n_closest_places(n, landmarks, float(lat), float(lon))
    serializer = PlaceSerializer(closest_places, many=True)
    return Response(serializer.data)

@api_view()
@permission_classes([])
def bikepoint_number_of_bikes(request, bikepoint_id):
    """
    Retrieve the number of available bikes a certain bikepoint has
    """
    return Response({'Number of bikes' : bikepoint_get_property(bikepoint_id, 'NbBikes')})

@api_view()
@permission_classes([])
def bikepoint_number_of_empty_docks(request, bikepoint_id):
    """
    Retrieve the number of empty docks a certain bikepoint has
    """
    return Response({'Number of empty docks' : bikepoint_get_property(bikepoint_id, 'NbEmptyDocks')})

@api_view()
@permission_classes([])
def get_closest_available_bikepoint(request, min_bikes, lat, lon):
    """
    Retrieve the closest bikepoint with at least min_bikes available bikes
    """
    bikepoints = Place.objects.filter(id__startswith='BikePoints')

    coordinates = (lat, lon)
    queue = get_places_by_distance(bikepoints, lat, lon)
    closest_bikepoint = None
    while (not queue.empty()) and closest_bikepoint is None:
        bikepoint = queue.get()[1]
        NbBikes = bikepoint_get_property(bikepoint.id, 'NbBikes')
        if NbBikes is not None and int(NbBikes) >= min_bikes:
            closest_bikepoint = bikepoint

    serializer = PlaceSerializer(closest_bikepoint)
    return Response(serializer.data)

@api_view()
@permission_classes([])
def get_closest_bikepoint_with_empty_docks(request, min_empty_docks, lat, lon):
    """
    Retrieve the closest bikepoint with at least min_empty_docks empty docks
    """
    bikepoints = Place.objects.filter(id__startswith='BikePoints')

    coordinates = (lat, lon)
    queue = get_places_by_distance(bikepoints, lat, lon)
    closest_bikepoint = None
    while (not queue.empty()) and closest_bikepoint is None:
        bikepoint = queue.get()[1]
        NbEmptyDocks = bikepoint_get_property(bikepoint.id, 'NbEmptyDocks')
        if NbEmptyDocks is not None and int(NbEmptyDocks) >= min_empty_docks:
            closest_bikepoint = bikepoint

    serializer = PlaceSerializer(closest_bikepoint)
    return Response(serializer.data)

class PlaceViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows places to be viewed or edited.
    """
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer
    permission_classes = []


class BikePointViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows bikepoints to be viewed or edited.
    """
    queryset = Place.objects.filter(id__startswith='BikePoints')
    serializer_class = PlaceSerializer
    permission_classes = []


class LandmarkViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows landmarks to be viewed or edited.
    """
    queryset = Place.objects.filter(id__startswith='Landmark')
    serializer_class = PlaceSerializer
    permission_classes = []


# Signup view
@api_view(['POST'])
@permission_classes([])
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
        response_data = {
            "detail": serializer.errors['email'][0]
        }
        return Response(response_data, 400)
    return Response(response_data)


# Update user profile
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_profile_view(request):
    serializer = UserSerializer(data=request.data)
    user = request.user
    if serializer.is_valid():
        response_data = update_user(user, serializer.data)
    else:
        if serializer.data['email'] == user.email:
            response_data = update_user(user, serializer.data)
        else:
            response_data = {
                "detail": serializer.errors['email'][0]
            }
            return Response(response_data, 400)
    return Response(response_data)


# Get user details
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_user_details_view(request):
    user = request.user

    response_data = {
        'first_name': user.first_name,
        'last_name': user.last_name,
        'email': user.email
    }

    return Response(response_data)


""" Used to update user and return a response containing his updated information """


def update_user(user, data):
    user.first_name = data['first_name']
    user.last_name = data['last_name']
    user.email = data['email']
    user.set_password(data['password'])
    user.save()

    response_data = {
        'response': "Update was successful",
        'first_name': user.first_name,
        'last_name': user.last_name,
        'email': user.email,
    }
    return response_data

# Each restful view that needs user to be authenticated to access it, MUST be stated as:
#
# @api_view([POST/GET/PUT])
# @permission_classes([IsAuthenticated])
# def view_name(request):
#   ...
#
# Each call to the api view must have a  token in the header: "Authorization" : "Token {actual_token}"
