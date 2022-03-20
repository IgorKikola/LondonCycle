import 'package:cycle/services/route.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String kApiKey =
    'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';
const String kMapBoxURL = 'api.mapbox.com';

// directions specific for cyclists
const String kRouteMode = 'mapbox/cycling';

class DirectionsService {
  static Future<List<String>> getInstructionsForRoute(MyRoute route) async {
    List<String> resultsList = ['some_instruction1', 'some_instruction2'];

    String locationsToVisit =
        route.getRouteAsSemicolonSeparatedListWithLongLatOrder();
    var url =
        Uri.https(kMapBoxURL, '/directions/v5/$kRouteMode/$locationsToVisit', {
      'geometries': 'geojson',
      'language': 'en',
      'overview': 'simplified',
      'steps': 'true',
      'access_token': kApiKey
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      int responseLength = jsonResponse['routes'][0]['legs'][0]['steps'].length;

      if (jsonResponse['routes'][0]['legs'][0]['steps'].length > 0) {
        resultsList.clear();
      }

      for (int i = 0; i < responseLength; i++) {
        String instructionPrompt = jsonResponse['routes'][0]['legs'][0]['steps']
            [i]['maneuver']['instruction'];
        print(instructionPrompt);
        resultsList.add(instructionPrompt);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return resultsList;
  }
}
