import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cycle/models/stop.dart';
import 'package:http/http.dart' as http;

class StopProvider with ChangeNotifier {
  StopProvider() {
    getStops();
  }

  List<JourneyStop> _stops = [];

  List<JourneyStop> get stops {
    return [..._stops];
  }

  void addStop(JourneyStop stop) async {
    final url = 'https://agile-citadel-13372.herokuapp.com/stops/';
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(stop));
    if (response.statusCode == 201) {
      _stops.add(stop);
      notifyListeners();
    }
  }

  void deleteStop(JourneyStop stop) async {
    final url = 'https://agile-citadel-13372.herokuapp.com/stops/${stop.id}/';
    final response = await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(stop));
    if (response.statusCode == 204) {
      _stops.remove(stop);
      notifyListeners();
    }
  }

  getStops() async {
    final url = 'https://agile-citadel-13372.herokuapp.com/stops/?format=json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'] as List;
      _stops =
          data.map<JourneyStop>((json) => JourneyStop.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
