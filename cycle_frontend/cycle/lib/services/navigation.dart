import 'dart:async';

import 'package:cycle/models/docking_station.dart';
import 'package:cycle/pages/loading_screens/navigation_loading_screen.dart';
import 'package:cycle/services/data_managers/bikepoint_data_manager.dart';
import 'package:cycle/services/map_manager.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';

///Navigation class responsible for splitting route into walking and cycling
///sub-routes according to the number of riders and setting up navigators for them.
class Navigation {
  final List<LatLng> _stops;
  final dynamic _context;
  final int _numberOfRiders;
  late DockingStation _startDockingStation;
  late DockingStation _stopDockingStation;

  Navigation(this._context, this._stops, this._numberOfRiders);

  Future<void> navigate() async {
    for (int i = 0; i < _stops.length - 1; i++) {
      await buildRouteBetweenTwoPoints(
          _stops[i], _stops[i + 1], _numberOfRiders);
    }
  }

  Future<void> buildRouteBetweenTwoPoints(
      LatLng start, LatLng stop, int numberOfRiders) async {
    await Navigator.push(_context, MaterialPageRoute(builder: (context) {
      return NavigationLoadingScreen(action: () async {
        await _getDockingStations(start, stop);
      });
    }));

    await walk(
        start, LatLng(_startDockingStation.lat, _startDockingStation.lon));

    await cycle(LatLng(_startDockingStation.lat, _startDockingStation.lon),
        LatLng(_stopDockingStation.lat, _stopDockingStation.lon));

    await walk(LatLng(_stopDockingStation.lat, _stopDockingStation.lon), stop);
  }

  Future<void> walk(LatLng start, LatLng stop) async {
    MapManager mapManager = MapManager(_context);
    await Future.delayed(const Duration(milliseconds: 500));
    await mapManager.openMapsSheet(start, stop, DirectionsMode.walking);
  }

  Future<void> cycle(LatLng start, LatLng stop) async {
    MapManager mapManager = MapManager(_context);
    await Future.delayed(const Duration(milliseconds: 500));
    await mapManager.openMapsSheet(start, stop, DirectionsMode.bicycling);
  }

  Future<void> _getDockingStations(LatLng start, LatLng stop) async {
    _startDockingStation = await getClosestDockingStationWithBikesAvailable(
        start, _numberOfRiders);
    _stopDockingStation =
        await getClosestDockingStationWithEmptyDocks(stop, _numberOfRiders);
  }
}
