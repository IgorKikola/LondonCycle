import 'dart:async';
import 'package:cycle/models/docking_station.dart';
import 'package:cycle/services/data_manager.dart';
import 'package:cycle/services/map_manager.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';

class Navigation {
  List<LatLng> _stops = [];
  final _context;
  int _numberOfRiders;

  Navigation(this._context, this._stops, this._numberOfRiders);

  void navigate() async {
    for (int i = 0; i < _stops.length - 1; i++) {
      await buildRouteBetweenTwoPoints(
          _stops[i], _stops[i + 1], _numberOfRiders);
    }
  }

  Future<void> buildRouteBetweenTwoPoints(
      LatLng start, LatLng stop, int numberOfRiders) async {
    DockingStation startDockingStation =
        await getClosestDockingStationWithBikesAvailable(start, numberOfRiders);
    DockingStation stopDockingStation =
        await getClosestDockingStationWithEmptyDocks(stop, numberOfRiders);

    await walk(start, LatLng(startDockingStation.lat, startDockingStation.lon));

    await cycle(LatLng(startDockingStation.lat, startDockingStation.lon),
        LatLng(stopDockingStation.lat, stopDockingStation.lon));

    await walk(LatLng(stopDockingStation.lat, stopDockingStation.lon), stop);
  }

  Future<void> walk(LatLng start, LatLng stop) async {
    MapManager mapManager = MapManager(_context);
    await mapManager.openMapsSheet(start, stop, DirectionsMode.walking);
  }

  Future<void> cycle(LatLng start, LatLng stop) async {
    MapManager mapManager = MapManager(_context);
    await mapManager.openMapsSheet(start, stop, DirectionsMode.bicycling);
  }
}
