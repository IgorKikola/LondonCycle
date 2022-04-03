import 'dart:convert';

import 'package:cycle/models/map_box_route.dart';
import 'package:cycle/services/network_helper.dart';
import 'package:cycle/utilities/map_box_config.dart';

class MapBoxApiProvider {
  late MapBoxRoute mapBoxRoute;

  Future<MapBoxRoute> getRouteForLocations(String locationsToVisit) async {
    final response = await NetworkHelper.get(
        domain: MapBoxConfig.mapBoxURL,
        path: '${MapBoxConfig.mapBoxRoutingAPI}$locationsToVisit',
        params: {
          'geometries': 'geojson',
          'language': 'en',
          'overview': 'simplified',
          'steps': 'true',
          'access_token': MapBoxConfig.mapBoxAPIKey
        });

    if (response!.statusCode == 200) {
      mapBoxRoute = MapBoxRoute.fromJson(json.decode(response.body));
    } else {
      return MapBoxRoute(
          geometry: Geometry(coordinates: Coordinates(coordinatesList: [[]])));
    }

    return mapBoxRoute;
  }

  int getNumberOfCoordinates() {
    return mapBoxRoute.geometry.coordinates.coordinatesList.length;
  }
}
