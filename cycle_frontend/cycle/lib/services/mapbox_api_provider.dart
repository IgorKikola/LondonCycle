import 'package:cycle/models/map_box_route.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

const String kApiKey =
    'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';
const String kMapBoxURL = 'api.mapbox.com';

// directions specific for cyclists
const String kRouteMode = 'mapbox/cycling';

class MapBoxApiProvider {
  Client client = Client();
  late MapBoxRoute mapBoxRoute;

  Future<MapBoxRoute> fetchRoute(String locationsToVisit) async {
    var url =
        Uri.https(kMapBoxURL, '/directions/v5/$kRouteMode/$locationsToVisit', {
      'geometries': 'geojson',
      'language': 'en',
      'overview': 'simplified',
      'steps': 'true',
      'access_token': kApiKey
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
