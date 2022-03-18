from geopy import distance
from queue import PriorityQueue
from cycle_backend.cycle_api.models import Place
from cycle_backend.cycle_api.serializers import PlaceSerializer

def get_n_closest_places(n, queryset, lat, lon):
    """
    Get the n closest places from the place with coordinates (lat, lon),
    selected from the given queryset of places.
    """
    if len(queryset) <= n:
        return queryset
    else:
        coordinates = (lat, lon)
        queue = PriorityQueue()
        for place in queryset:
            dist = distance.distance(
                (place.lat, place.lon),
                coordinates
            )
            queue.put((dist, place))
        closest_places = []
        for i in range(n):
            closest_places.append(queue.get()[1])
        return closest_places
