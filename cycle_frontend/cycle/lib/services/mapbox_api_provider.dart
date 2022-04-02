import 'dart:convert';

import 'package:cycle/models/map_box_route.dart';
import 'package:cycle/utilities/map_box_config.dart';
import 'package:http/http.dart' show Client;

class MapBoxApiProvider {
  Client client = Client();
  late MapBoxRoute mapBoxRoute;

  Future<MapBoxRoute> fetchRoute(String locationsToVisit) async {
    var url = Uri.https(MapBoxConfig.mapBoxURL,
        '${MapBoxConfig.mapBoxRoutingAPI}$locationsToVisit', {
      'geometries': 'geojson',
      'language': 'en',
      'overview': 'simplified',
      'steps': 'true',
      'access_token': MapBoxConfig.mapBoxAPIKey
    });

    final response = await client.get(url);
    if (response.statusCode == 200) {
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
