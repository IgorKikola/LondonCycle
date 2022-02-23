import 'dart:convert';
import 'package:cycle/docking_station.dart';
import 'package:http/http.dart' as http;

const String kBackEndUrl = 'http://127.0.0.1:8000';

const String kPlacesPath = 'places/';

Future<List<DockingStation>> getDockingStations() async {
  var dockingStationsAsJson = (await getData(kBackEndUrl, kPlacesPath));

  if (dockingStationsAsJson == null) {
    return List.empty();
  }

  var dockingStationsAsJsonList = dockingStationsAsJson as List;

  List<DockingStation> dockingStations = dockingStationsAsJsonList
      .map((dockingStation) => DockingStation.fromJson(dockingStation))
      .toList();

  return dockingStations;
}

Future<dynamic>? getData(String apiUri, String path) async {
  http.Response response = await http.get(Uri.http(apiUri, path));

  if (response.statusCode == 200) {
    String data = response.body;
    return jsonDecode(data);
  } else {
    return null;
  }
}
