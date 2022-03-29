import 'dart:async';
import 'package:cycle/models/docking_station.dart';
import 'package:cycle/models/stop.dart';
import 'package:cycle/services/data_manager.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:latlong2/latlong.dart';

class Navigation {
  final List<LatLng> _stops = [
    LatLng(51.510357, -0.116773),
    LatLng(51.504501, -0.086500)
  ];

  final int numberOfRiders = 3;

  late MapBoxNavigation _directions;
  late MapBoxOptions _walkingOptions;
  late MapBoxOptions _cyclingOptions;

  Navigation() {
    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);

    _walkingOptions = MapBoxOptions(
        //initialLatitude: 36.1175275,
        //initialLongitude: -115.1839524,
        zoom: 19.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: true,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.walking,
        units: VoiceUnits.imperial,
        simulateRoute: true, //uncomment for debugging
        animateBuildRoute: true,
        language: "en");

    _cyclingOptions = MapBoxOptions(
        //initialLatitude: 36.1175275,
        //initialLongitude: -115.1839524,
        zoom: 19.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: true,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.cycling,
        units: VoiceUnits.imperial,
        simulateRoute: true, //uncomment for debugging
        animateBuildRoute: true,
        language: "en");
  }

  void navigate() async {
    for (int i = 0; i < _stops.length; i++) {
      await buildRouteBetweenTwoPoints(
          _stops[i], _stops[i + 1], numberOfRiders);
    }
  }

  Future<void> buildRouteBetweenTwoPoints(
      LatLng start, LatLng stop, int numberOfRiders) async {
    DockingStation startDockingStation =
        await getClosestDockingStationWithBikesAvailable(start, numberOfRiders);
    DockingStation stopDockingStation =
        await getClosestDockingStationWithEmptyDocks(stop, numberOfRiders);

    await buildWalkingRouteBetweenTwoPoints(
        start, LatLng(startDockingStation.lat, startDockingStation.lon));

    await buildCyclingRouteBetweenTwoPoints(
        LatLng(startDockingStation.lat, startDockingStation.lon),
        LatLng(stopDockingStation.lat, stopDockingStation.lon));

    await buildWalkingRouteBetweenTwoPoints(
        LatLng(stopDockingStation.lat, stopDockingStation.lon), stop);
  }

  Future<void> buildWalkingRouteBetweenTwoPoints(
      LatLng start, LatLng stop) async {
    var wayPoints = <WayPoint>[];
    wayPoints.add(WayPoint(
        name: "Start", latitude: start.latitude, longitude: start.longitude));
    wayPoints.add(WayPoint(
        name: "Stop", latitude: stop.latitude, longitude: stop.longitude));

    await _directions.startNavigation(
        wayPoints: wayPoints, options: _walkingOptions);
  }

  Future<void> buildCyclingRouteBetweenTwoPoints(
      LatLng start, LatLng stop) async {
    var wayPoints = <WayPoint>[];
    wayPoints.add(WayPoint(
        name: "Start", latitude: start.latitude, longitude: start.longitude));
    wayPoints.add(WayPoint(
        name: "Stop", latitude: stop.latitude, longitude: stop.longitude));

    await _directions.startNavigation(
        wayPoints: wayPoints, options: _cyclingOptions);
  }

  Future<void> _onEmbeddedRouteEvent(RouteEvent e) async {
    switch (e.eventType) {
      case MapBoxEvent.on_arrival:
        await Future.delayed(const Duration(seconds: 6));
        await _directions.finishNavigation();
        break;
      case MapBoxEvent.navigation_cancelled:
        await _directions.finishNavigation();
        break;
      case MapBoxEvent.navigation_finished:
        await _directions.finishNavigation();
        break;
      default:
        break;
    }
  }
}
