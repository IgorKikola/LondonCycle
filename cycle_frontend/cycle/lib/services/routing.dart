import 'package:cycle/services/routing_api_provider.dart';
import 'package:cycle/services/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/map_box_route.dart';
import '../models/route_coordinates.dart';
import 'mapbox_api_provider.dart';

class RoutingService {
  static List<LatLng> coordinates = [];

  static updateCoordinatesForRoute(MyRoute route) async {
    String locationsToVisit =
        route.getRouteAsSemicolonSeparatedListWithLongLatOrder();

    MapBoxApiProvider mapBoxApiProvider = MapBoxApiProvider();
    MapBoxRoute mapBoxRoute =
        await mapBoxApiProvider.fetchRoute(locationsToVisit);
    int numberOfCoordinates = mapBoxApiProvider.getNumberOfCoordinates();

    //TODO: decide which API to use
    // RoutingApiProvider routingApiProvider = RoutingApiProvider();
    // RouteCoordinates routeCoordinates =
    //     await routingApiProvider.fetchCoordinates(route);
    //
    // int numberOfCoordinates = routeCoordinates.coordinatesList.length;

    if (numberOfCoordinates > 0) {
      coordinates.clear();
    }

    for (int i = 0; i < numberOfCoordinates; i++) {
      var coordinate = mapBoxRoute.geometry.coordinates.coordinatesList[i];
      double lat = coordinate[1];
      double long = coordinate[0];

      //TODO: decide which API to use
      // var coordinate = routeCoordinates.coordinatesList[i];
      // double lat = coordinate[0];
      // double long = coordinate[1];

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
