import 'dart:convert';

import 'package:cycle/utilities/config.dart';
import 'package:cycle/services/route.dart';
import 'package:http/http.dart' show Client;

import '../utilities/config.dart';
import '../models/route_coordinates.dart';

class RoutingApiProvider {
  Client client = Client();
  late RouteCoordinates routeCoordinates;

  Future<RouteCoordinates> fetchCoordinates(MyRoute myRoute) async {
    String startingLocation = myRoute.startingLocation!.latitude.toString() +
        ',' +
        myRoute.startingLocation!.longitude.toString();
    String finishingLocation = myRoute.finishingLocation!.latitude.toString() +
        ',' +
        myRoute.finishingLocation!.longitude.toString();
    String viaLocations = myRoute.getFormattedWaypointsLatLongOrder();

    String apiCallPath;

    if (myRoute.waypoints.length > 1) {
      apiCallPath =
          '${Config.routingMultipleStopsPath}from/$startingLocation/via/$viaLocations/to/$finishingLocation/';
    } else if (myRoute.waypoints.length == 1) {
      apiCallPath =
          '${Config.routingSingleStopPath}from/$startingLocation/via/$viaLocations/to/$finishingLocation/';
    } else {
      apiCallPath =
          '${Config.routingPath}from/$startingLocation/to/$finishingLocation/';
    }

    var url = Uri.https(Config.backendURL, apiCallPath, {
      'format': 'json',
    });

    final response = await client.get(url);
    if (response.statusCode == 200) {
      routeCoordinates = RouteCoordinates.fromJson(json.decode(response.body));
    } else {
      return RouteCoordinates(coordinatesList: [[]]);
    }

    return routeCoordinates;
  }

  int getNumberOfCoordinates() {
    return routeCoordinates.coordinatesList.length;
  }
}
