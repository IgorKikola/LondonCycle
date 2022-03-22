from geopy import distance
from queue import PriorityQueue
from cycle_backend.cycle_api.models import Place
from cycle_backend.cycle_api.serializers import PlaceSerializer
import requests

def get_places_by_distance(queryset, lat, lon):
    """
    Returns a priority queue of places, with their distance from a
    given point as keys.
    """
    coordinates = (lat, lon)
    queue = PriorityQueue()
    for place in queryset:
        dist = distance.distance(
            (place.lat, place.lon),
            coordinates
        )
        queue.put((dist, place))
    return queue

def get_n_closest_places(n, queryset, lat, lon):
    """
    Get the n closest places from the place with coordinates (lat, lon),
    selected from the given queryset of places.
    """
    if len(queryset) <= n:
        return queryset
    else:
        coordinates = (lat, lon)
        queue = get_places_by_distance(queryset, lat, lon)
        closest_places = []
        for i in range(n):
            closest_places.append(queue.get()[1])
        return closest_places


def bikepoint_get_property(bikepoint_id, property_key):
    """
    Retrieves the value of a specific property of a bikepoint.
    Returns None if it doesn't exist.
    """
    response = requests.get(f'https://api.tfl.gov.uk/BikePoint/{bikepoint_id}')
    additionalProperties = response.json()['additionalProperties']
    value = None
    for property in additionalProperties:
        if property['key'] == property_key:
            value = property['value']
    return value
