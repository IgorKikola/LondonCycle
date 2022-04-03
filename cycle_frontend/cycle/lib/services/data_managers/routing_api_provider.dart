import 'dart:convert';

import 'package:cycle/services/network_helper.dart';
import 'package:cycle/services/route.dart';
import 'package:cycle/utilities/config.dart';

import '../../models/route_coordinates.dart';
import '../../utilities/config.dart';

/// This class is created to use backend response that bases routing on Tfl,
/// which is not satisfactory since this class is not used in the final scope of the project.
class RoutingApiProvider {
  late RouteCoordinates routeCoordinates;

  Future<RouteCoordinates> getCoordinates(MyRoute myRoute) async {
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

    final response = await NetworkHelper.get(
        domain: Config.backendURL,
        path: apiCallPath,
        params: {
          'format': 'json',
        });

    if (response!.statusCode == 200) {
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
