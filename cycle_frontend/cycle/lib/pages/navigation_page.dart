import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';

class NavigationPage extends StatefulWidget {
  static const String id = 'navigation_page';
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _home =
      WayPoint(name: "Home", latitude: 51.458060, longitude: -0.371500);

  final _store =
      WayPoint(name: "Store", latitude: 51.469613, longitude: -0.357147);

  late MapBoxNavigation _directions;
  late MapBoxOptions _options;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
        //initialLatitude: 36.1175275,
        //initialLongitude: -115.1839524,
        zoom: 15.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: true,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: true,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

    navigate();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text("CACA"),
        ),
      ),
    );
  }

  Future<void> _onEmbeddedRouteEvent(RouteEvent e) async {
    switch (e.eventType) {
      case MapBoxEvent.progress_change:
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {});
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {});
        break;
      case MapBoxEvent.navigation_running:
        setState(() {});
        break;
      case MapBoxEvent.on_arrival:
        await Future.delayed(const Duration(seconds: 6));
        await _directions.finishNavigation();
        setState(() {});
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {});
        break;
      default:
        break;
    }
    setState(() {});
  }

  void navigate() async {
    var wayPoints = <WayPoint>[];
    wayPoints.add(_home);
    wayPoints.add(_store);

    await _directions.startNavigation(wayPoints: wayPoints, options: _options);
  }
}
