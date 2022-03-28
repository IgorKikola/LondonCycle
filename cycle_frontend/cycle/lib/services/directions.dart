import 'package:cycle/models/map_box_route.dart';
import 'package:cycle/services/mapbox_api_provider.dart';
import 'package:cycle/services/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DirectionsService {
  static List<LatLng> coordinates = [];

  // static Future<List<String>> getInstructionsForRoute(MyRoute route) async {
  //   List<String> resultsList = ['some_instruction1', 'some_instruction2'];
  //
  //   String locationsToVisit =
  //       route.getRouteAsSemicolonSeparatedListWithLongLatOrder();
  //   var url =
  //       Uri.https(kMapBoxURL, '/directions/v5/$kRouteMode/$locationsToVisit', {
  //     'geometries': 'geojson',
  //     'language': 'en',
  //     'overview': 'simplified',
  //     'steps': 'true',
  //     'access_token': kApiKey
  //   });
  //
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     int responseLength = jsonResponse['routes'][0]['legs'][0]['steps'].length;
  //
  //     if (jsonResponse['routes'][0]['legs'][0]['steps'].length > 0) {
  //       resultsList.clear();
  //     }
  //
  //     for (int i = 0; i < responseLength; i++) {
  //       String instructionPrompt = jsonResponse['routes'][0]['legs'][0]['steps']
  //           [i]['maneuver']['instruction'];
  //       print(instructionPrompt);
  //       resultsList.add(instructionPrompt);
  //     }
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  //
  //   return resultsList;
  // }

  static updateCoordinatesForRoute(MyRoute route) async {
    String locationsToVisit =
        route.getRouteAsSemicolonSeparatedListWithLongLatOrder();

    MapBoxApiProvider mapBoxApiProvider = MapBoxApiProvider();
    MapBoxRoute mapBoxRoute =
        await mapBoxApiProvider.fetchRoute(locationsToVisit);
    int numberOfCoordinates = mapBoxApiProvider.getNumberOfCoordinates();

    if (numberOfCoordinates > 0) {
      coordinates.clear();
    }

    for (int i = 0; i < numberOfCoordinates; i++) {
      var coordinate = mapBoxRoute.geometry.coordinates.coordinatesList[i];
      double lat = coordinate[1];
      double long = coordinate[0];
      String latInfo = lat.toString();
      String longInfo = long.toString();
      String coordinateInfo = 'lat: $latInfo, long: $longInfo';

      LatLng latLng = LatLng(lat, long);
      coordinates.add(latLng);

      print(coordinateInfo);
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
