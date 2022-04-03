import 'package:cycle/services/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/map_box_route.dart';
import 'data_managers/mapbox_api_provider.dart';

class RoutingService {
  static List<LatLng> coordinates = [];

  static updateCoordinatesForRoute(MyRoute route) async {
    String locationsToVisit =
        route.getRouteAsSemicolonSeparatedListWithLongLatOrder();

    MapBoxApiProvider mapBoxApiProvider = MapBoxApiProvider();
    MapBoxRoute mapBoxRoute =
        await mapBoxApiProvider.getRouteForLocations(locationsToVisit);
    int numberOfCoordinates = mapBoxApiProvider.getNumberOfCoordinates();

    if (numberOfCoordinates > 0) {
      coordinates.clear();
    }

    for (int i = 0; i < numberOfCoordinates; i++) {
      var coordinate = mapBoxRoute.geometry.coordinates.coordinatesList[i];
      double lat = coordinate[1];
      double long = coordinate[0];

      LatLng latLng = LatLng(lat, long);
      coordinates.add(latLng);
    }
  }

  static List<Polyline> getPolylines() {
    return [
      Polyline(
        points: coordinates,
        color: const Color(0xFF0000FF),
        strokeWidth: 3.0,
      )
    ];
  }
}
