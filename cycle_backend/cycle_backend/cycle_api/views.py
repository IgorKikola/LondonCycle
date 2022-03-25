from rest_framework import viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticatedOrReadOnly, IsAuthenticated
from django.utils.decorators import method_decorator
from .serializers import PlaceSerializer, SignupSerializer, UserSerializer, StopSerializer
from .models import Place, Stop

from geopy import distance
from queue import PriorityQueue
from rest_framework import permissions
from cycle_backend.cycle_api.serializers import UserSerializer, PlaceSerializer
from cycle_backend.cycle_api.models import Place
from rest_framework.decorators import api_view
from rest_framework.response import Response
from jsonmerge import Merger
from .helpers import get_n_closest_places, bikepoint_get_property, get_places_by_distance, string_to_list_of_coordinates
import requests

@api_view()
@permission_classes([])
def get_list_of_stops(request, string_of_stops):
    stops = string_to_list_of_coordinates(string_of_stops)
    start = stops.pop(0)
    end = stops.pop()
    stopsQueue = get_places_by_distance(stops, start.lat, start.lon)
    sortedStops = []
    for i in range(len(stops)):
        sortedStops.append(stopsQueue.get()[1])

    sortedStops = [start] + sortedStops + [end]

    finalList = []
    bikepoints = Place.objects.filter(id__startswith='BikePoints')
    for i in range(len(sortedStops)):
        stop = sortedStops[i]
        finalList.append(stop)
        closest_bikepoint = get_n_closest_places(1, bikepoints, stop.lat, stop.lon)[0]
        finalList.append((closest_bikepoint.lat, closest_bikepoint.lon))

    json = {}
    for i in range(len(finalList)):
        json[i] = finalList[i]
    return Response(finalList)


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
    return Response({'Number of bikes': bikepoint_get_property(bikepoint_id, 'NbBikes')})


@api_view()
@permission_classes([])
def bikepoint_number_of_empty_docks(request, bikepoint_id):
    """
    Retrieve the number of empty docks a certain bikepoint has
    """
    return Response({'Number of empty docks': bikepoint_get_property(bikepoint_id, 'NbEmptyDocks')})


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


class StopViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows stops to be viewed or edited.
    """
    queryset = Stop.objects.all()
    serializer_class = StopSerializer


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
        return Response(response_data, status=400)
    return Response(response_data)


# Update user profile
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def update_profile_view(request):
    serializer = UserSerializer(data=request.data)
    user = request.user
    if serializer.is_valid():
        # If new email does not exist in the database already and first/last names are of a valid format
        response_data = update_user(user, serializer.data)
    else:
        # If it exists, check if all the necessary fields are provided
        # and then check if the new email is users current email.
        # Same user ---> update the rest of the details although serializer is not valid provided that it is not valid
        # because it gave an error about already existing email.
        error_keys = list(serializer.errors)
        if len(error_keys) == 1 and 'email' in serializer.errors and\
                serializer.errors['email'][0] != "This field is required." and serializer.data['email'] == user.email:
            response_data = update_user(user, serializer.data)
        else:
            response_data = {
                "detail": serializer.errors
            }
            return Response(response_data, status=400, content_type="application/json")
    return Response(response_data, content_type="application/json")


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

    return Response(response_data, content_type="application/json")


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
