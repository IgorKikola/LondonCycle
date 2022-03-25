import 'dart:async';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:latlong2/latlong.dart';

class Navigation {
  final List<LatLng> _stops = [
    LatLng(51.510357, -0.116773),
    LatLng(51.504501, -0.086500)
  ];

  final _home =
      WayPoint(name: "Home", latitude: 51.458060, longitude: -0.371500);

  final _store =
      WayPoint(name: "Store", latitude: 51.469613, longitude: -0.357147);

  late MapBoxNavigation _directions;
  late MapBoxOptions _options;

  Navigation() {
    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
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
    var wayPoints = <WayPoint>[];
    wayPoints.add(_home);
    wayPoints.add(_store);
    await _directions.startNavigation(wayPoints: wayPoints, options: _options);
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
