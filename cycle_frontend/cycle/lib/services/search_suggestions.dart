import 'dart:convert' as convert;

import 'package:cycle/config.dart';
import 'package:cycle/services/location_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

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
    List<String> resultsList = await _getClosestLandmarksForCurrentLocation();

    var url = Uri.https(
        Config.mapBoxURL, '${Config.mapBoxGeocodingAPI}$pattern.json', {
      'bbox':
          '$kBoundingBoxMinLongitude,$kBoundingBoxMinLatitude,$kBoundingBoxMaxLongitude,$kBoundingBoxMaxLatitude',
      'proximity': '$kProximityCenterLongitude, $kProximityCenterLatitude',
      'access_token': Config.mapBoxAPIKey
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

        String locationDetails =
            _getLocationDetails(jsonResponse, i, contextLength);

        String objectLongitude =
            jsonResponse['features'][i]['center'][0].toString();
        String objectLatitude =
            jsonResponse['features'][i]['center'][1].toString();

        String merged = _encodeSuggestionParameters(
            locationTitle, locationDetails, objectLongitude, objectLatitude);

        resultsList.add(merged);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return resultsList;
  }

  static Future<Map<String, String>> getNBikeStationForCurrentLocation(
      int n) async {
    List bikeStationsList = await _getClosestBikeStationsForCurrentLocation();

    return bikeStationsList[0].elementAt(n);
  }

  static Future<Map<double, double>>
      getNBikeStationForCurrentLocationCoordinates(int n) async {
    List bikeStationsList = await _getClosestBikeStationsForCurrentLocation();

    return bikeStationsList[1].elementAt(n);
  }

  static String _getLocationDetails(
      Map<String, dynamic> jsonResponse, int i, int contextLength) {
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
        locationDetails =
            locationDetails + jsonResponse['features'][i]['context'][j]['text'];
      }
    }
    return locationDetails;
  }

  static String _encodeSuggestionParameters(String locationTitle,
      String locationDetails, String objectLongitude, String objectLatitude) {
    return locationTitle +
        '|' +
        locationDetails +
        '|' +
        objectLongitude +
        '|' +
        objectLatitude;
  }

  static Future<List<String>> _getClosestLandmarksForCurrentLocation() async {
    List<String> landmarksList = List.empty(growable: true);

    Position currentPosition = await getPosition();
    String latitude = currentPosition.latitude.toString();
    String longitude = currentPosition.longitude.toString();

    var url = Uri.https(Config.apiURL,
        '${Config.fiveClosestLandmarksAPI}$latitude/$longitude/', {
      'format': 'json',
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      int responseLength = jsonResponse.length;

      for (int i = 0; i < responseLength; i++) {
        String locationTitle = jsonResponse[i]['name'];

        String locationDetails = '';

        String objectLongitude = jsonResponse[i]['lon'].toString();
        String objectLatitude = jsonResponse[i]['lat'].toString();

        String merged = _encodeSuggestionParameters(
            locationTitle, locationDetails, objectLongitude, objectLatitude);

        landmarksList.add(merged);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return landmarksList;
  }

  static Future<List> _getClosestBikeStationsForCurrentLocation() async {
    List bikeStations = [];
    List<Map<double, double>> bikeStationsCoordinates =
        List.empty(growable: true);
    List<Map<String, String>> bikeStationsList = List.empty(growable: true);

    Position currentPosition = await getPosition();
    String latitude = currentPosition.latitude.toString();
    String longitude = currentPosition.longitude.toString();

    var url = Uri.https(Config.apiURL,
        '${Config.fiveClosestBikePointsAPI}$latitude/$longitude/', {
      'format': 'json',
    });

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      int responseLength = jsonResponse.length;

      for (int i = 0; i < responseLength; i++) {
        String locationTitle = jsonResponse[i]['name'];
        double locationLatitude = jsonResponse[i]['lat'];
        double locationLongitude = jsonResponse[i]['lon'];
        locationTitle = locationTitle.substring(0, locationTitle.indexOf(','));

        Map<String, String> bikeStationPair = {
          locationTitle: _getDistanceBetween(currentPosition.latitude,
              currentPosition.longitude, locationLatitude, locationLongitude)
        };
        Map<double, double> coordinatesPair = {
          locationLatitude: locationLongitude
        };
        bikeStationsList.add(bikeStationPair);
        bikeStationsCoordinates.add(coordinatesPair);
      }
      bikeStations.add(bikeStationsList);
      bikeStations.add(bikeStationsCoordinates);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return bikeStations;
  }

  static String _getDistanceBetween(double latitude1, double longitude1,
      double latitude2, double longitude2) {
    const Distance distance = Distance();
    String distanceInMeters =
        distance(LatLng(latitude1, longitude1), LatLng(latitude2, longitude2))
            .toInt()
            .toString();

    String suffix = 'm';
    return distanceInMeters + suffix;
  }
}
