import 'dart:convert';

import 'package:cycle/models/docking_station.dart';
import 'package:cycle/models/journey_stop.dart';
import 'package:cycle/models/landmark.dart';
import 'package:cycle/models/stop.dart';
import 'package:cycle/services/network_helper.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/config.dart';

Future<DockingStation> getClosestDockingStationWithBikesAvailable(
    LatLng latLng, int numberOfBikes) async {
  var response = await NetworkHelper.get(
      domain: Config.backendUrl,
      path: (Config.closestBikePointPath +
          "/with/$numberOfBikes/bikes/from/${latLng.latitude}/${latLng.longitude}"));
  DockingStation dockingStation =
      DockingStation.fromJson(jsonDecode(response!.body));

  return dockingStation;
}

Future<DockingStation> getClosestDockingStationWithEmptyDocks(
    LatLng latLng, int numberOfBikes) async {
  var response = await NetworkHelper.get(
      domain: Config.backendUrl,
      path: (Config.closestBikePointPath +
          "/with/$numberOfBikes/empty_docks/from/${latLng.latitude}/${latLng.longitude}"));
  DockingStation dockingStation =
      DockingStation.fromJson(jsonDecode(response!.body));

  return dockingStation;
}

Future<List<DockingStation>> getDockingStations() async {
  List<DockingStation> dockingStations = (await NetworkHelper.getJsonList(
          domain: Config.backendUrl, path: Config.bikePointsPath))
      .map((dockingStation) => DockingStation.fromJson(dockingStation))
      .toList();

  return dockingStations;
}

Future<List<Landmark>> getLandmarks() async {
  List<Landmark> landmarks = (await NetworkHelper.getJsonList(
          domain: Config.backendUrl, path: Config.landmarksPath))
      .map((landmark) => Landmark.fromJson(landmark))
      .toList();

  return landmarks;
}

Future<List<JourneyStop>> getStops() async {
  List<JourneyStop> journeyStops = (await NetworkHelper.getJsonList(
          domain: Config.backendUrl, path: Config.landmarksPath))
      .map((journeyStop) => JourneyStop.fromJson(journeyStop))
      .toList();

  return journeyStops;
}
