import 'dart:async';

import 'package:cycle/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/location_manager.dart';

const String kMapUrl =
    'https://api.mapbox.com/styles/v1/mariangartu/ckzjt4a9d000v14s451ltur5q/tiles/256/{z}/{x}/{y}@2x';
const String kAccessToken =
    'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const MapWidget();
  }
}

class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final LocationManager _locationManager = LocationManager();
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  late List<Marker> markers = [];

  @override
  void initState() {
    super.initState();

    _locationManager.run().whenComplete(() => setState(() {}));
    loadMarkers().whenComplete(() => setState(() {}));
    initUserLocationMarker();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    _locationManager.setStopped();
    super.dispose();
  }

  void initUserLocationMarker() {
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double?>();
  }

  void center() {
    // Automatically center the location marker on the map when location updated until user interact with the map.
    setState(
      () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
    );
    // Center the location marker on the map and zoom the map to level 18.
    _centerCurrentLocationStreamController.add(18);
  }

  Future<void> loadMarkers() async {
    markers = (await getDockingStations())
        .map((dockingStation) => Marker(
            point: LatLng(dockingStation.lat, dockingStation.lon),
            builder: (ctx) => const FlutterLogo()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(51.50, 0.12),
              zoom: 13,
              maxZoom: 19,
              // Stop centering the location marker on the map if user interacted with the map.
              onPositionChanged: (MapPosition position, bool hasGesture) {
                if (hasGesture) {
                  action:
                  () => setState(
                        () => _centerOnLocationUpdate =
                            CenterOnLocationUpdate.never,
                      );
                }
              },
            ),
            layers: [
              MarkerLayerOptions(markers: markers),
            ],
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate: '$kMapUrl?access_token=$kAccessToken',
                  maxZoom: 19,
                ),
              ),
              LocationMarkerLayerWidget(
                plugin: LocationMarkerPlugin(
                  centerCurrentLocationStream:
                      _centerCurrentLocationStreamController.stream,
                  centerOnLocationUpdate: _centerOnLocationUpdate,
                ),
              ),
              MarkerLayerWidget(
                options: MarkerLayerOptions(markers: markers),
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: center,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
