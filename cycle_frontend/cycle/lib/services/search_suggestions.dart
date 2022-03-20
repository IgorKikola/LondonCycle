import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const String kApiKey =
    'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';
const String kMapBoxForwardGeocodingURL = 'api.mapbox.com';

// bounding box coordinates restrict search results
// to a square containing London area
const String kBoundingBoxMinLongitude = '-01.00';
const String kBoundingBoxMinLatitude = '50.0';
const String kBoundingBoxMaxLongitude = '00.00';
const String kBoundingBoxMaxLatitude = '55.0';

// coordinates of Big Ben to prioritise results that are closer to the city centre
const String kProximityCenterLongitude = '-0.12463613127872614';
const String kProximityCenterLatitude = '51.50072917963769';

class BackendService {
  static Future<List<String>> getSuggestionsFromGeocoding(
      String pattern) async {
    List<String> resultsList = [
      'my_history_result1|Some location details|0.1|51.0',
      'my_history_result2|Some location details|0.1|51.0'
    ];

    var url = Uri.https(kMapBoxForwardGeocodingURL,
        '/geocoding/v5/mapbox.places/$pattern.json', {
      'bbox':
          '$kBoundingBoxMinLongitude,$kBoundingBoxMinLatitude,$kBoundingBoxMaxLongitude,$kBoundingBoxMaxLatitude',
      'proximity': '$kProximityCenterLongitude, $kProximityCenterLatitude',
      'access_token': kApiKey
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      int responseLength = jsonResponse['features'].length;

      if (jsonResponse['features'].length > 0) {
        resultsList.clear();
      }

      for (int i = 0; i < responseLength; i++) {
        String locationTitle = jsonResponse['features'][i]['text'];
        int contextLength = jsonResponse['features'][i]['context'].length;

        String locationDetails = '';

        if (jsonResponse['features'][i]['properties']['address'] != null) {
          locationDetails = locationDetails +
              jsonResponse['features'][i]['properties']['address'] +
              ', ';
        }

        for (int j = 0; j < contextLength; j++) {
          if (jsonResponse['features'][i]['context'][j]['id']
              .toString()
              .contains('neighborhood')) {
            locationDetails = locationDetails +
                jsonResponse['features'][i]['context'][j]['text'] +
                ', ';
          }
          if (jsonResponse['features'][i]['context'][j]['id']
              .toString()
              .contains('postcode')) {
            locationDetails = locationDetails +
                jsonResponse['features'][i]['context'][j]['text'] +
                ', ';
          }
          if (jsonResponse['features'][i]['context'][j]['id']
              .toString()
              .contains('locality')) {
            locationDetails = locationDetails +
                jsonResponse['features'][i]['context'][j]['text'];
          }
        }
        String objectLongitude =
            jsonResponse['features'][i]['center'][0].toString();
        String objectLatitude =
            jsonResponse['features'][i]['center'][1].toString();

        String merged = locationTitle +
            '|' +
            locationDetails +
            '|' +
            objectLongitude +
            '|' +
            objectLatitude;

        resultsList.add(merged);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return resultsList;
  }
}
