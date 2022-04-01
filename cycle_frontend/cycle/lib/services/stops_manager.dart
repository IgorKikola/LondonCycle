import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/journey_stop.dart';

class StopProvider with ChangeNotifier {
  StopProvider() {
    getStops();
  }

  List<JourneyStop> _stops = [];

  List<JourneyStop> get stops {
    return [..._stops];
  }

  void addStop(JourneyStop stop) async {
    final response = await http.post(Uri.parse(Config.stopsURL),
        headers: {"Content-Type": "application/json"}, body: json.encode(stop));
    if (response.statusCode == 201) {
      _stops.add(stop);
      notifyListeners();
    }
  }

  void deleteStop(JourneyStop stop) async {
    final url = '${Config.stopsURL}${stop.id}/';
    final response = await http.delete(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(stop));
    if (response.statusCode == 204) {
      _stops.remove(stop);
      notifyListeners();
    }
  }

  getStops() async {
    final url = '${Config.stopsURL}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['results'] as List;
      _stops =
          data.map<JourneyStop>((json) => JourneyStop.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
