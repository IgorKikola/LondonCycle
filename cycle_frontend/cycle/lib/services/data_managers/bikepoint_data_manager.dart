import 'dart:convert';

import 'package:cycle/models/docking_station.dart';
import 'package:cycle/models/landmark.dart';
import 'package:cycle/services/network_helper.dart';
import 'package:cycle/utilities/config.dart';
import 'package:latlong2/latlong.dart';

Future<DockingStation> getClosestDockingStationWithBikesAvailable(
    LatLng latLng, int numberOfBikes) async {
  var response = await NetworkHelper.get(
      domain: Config.backendURL,
      path: (Config.closestBikePointPath +
          "/with/$numberOfBikes/bikes/from/${latLng.latitude}/${latLng.longitude}"));
  DockingStation dockingStation =
      DockingStation.fromJson(jsonDecode(response!.body));

  return dockingStation;
}

Future<DockingStation> getClosestDockingStationWithEmptyDocks(
    LatLng latLng, int numberOfBikes) async {
  var response = await NetworkHelper.get(
      domain: Config.backendURL,
      path: (Config.closestBikePointPath +
          "/with/$numberOfBikes/empty_docks/from/${latLng.latitude}/${latLng.longitude}"));
  DockingStation dockingStation =
      DockingStation.fromJson(jsonDecode(response!.body));

  return dockingStation;
}

Future<List<DockingStation>> getDockingStations() async {
  List<DockingStation> dockingStations = (await NetworkHelper.getJsonList(
          domain: Config.backendURL, path: Config.bikePointsPath))
      .map((dockingStation) => DockingStation.fromJson(dockingStation))
      .toList();

  return dockingStations;
}

Future<List<Landmark>> getLandmarks() async {
  List<Landmark> landmarks = (await NetworkHelper.getJsonList(
          domain: Config.backendURL, path: Config.landmarksPath))
      .map((landmark) => Landmark.fromJson(landmark))
      .toList();

  return landmarks;
}
