import 'dart:async';

import 'package:cycle/services/data_manager.dart';
import 'package:cycle/services/directions.dart';
import 'package:cycle/services/location_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

const String kMapUrl =
    'https://api.mapbox.com/styles/v1/mariangartu/ckzjt4a9d000v14s451ltur5q/tiles/256/{z}/{x}/{y}@2x';
const String kAccessToken =
    'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';

class MainPage extends StatefulWidget {
  static const String id = 'main_page';
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final GlobalKey<_MapWidgetState> _myMapWidgetState =
      GlobalKey<_MapWidgetState>();
  final LocationManager _locationManager = LocationManager();

  void myMapRefresh() {
    print('my myMapRefresh called.');
    _myMapWidgetState.currentState?._myMapWidgetRefresh();
  }

  @override
  void initState() {
    super.initState();
    _locationManager.run().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    _locationManager.setStopped();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(key: _myMapWidgetState);
  }
}

class MapWidget extends StatefulWidget {
  MapWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  List<Marker> markers = [];

  void _myMapWidgetRefresh() {
    print('my myMapWidget called.');
    setState(() {
      print('inside myMapWidget setstate.');
    });
  }

  @override
  void initState() {
    super.initState();
    loadMarkers().whenComplete(() => setState(() {}));
    initUserLocationMarker();
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    super.dispose();
  }

  Future<void> loadMarkers() async {
    markers = (await getDockingStations())
        .map((dockingStation) => Marker(
            point: LatLng(dockingStation.lat, dockingStation.lon),
            builder: (ctx) => const Icon(
                  Icons.pedal_bike,
                  color: Colors.blue,
                )))
        .toList();
  }

  void initUserLocationMarker() {
    _centerOnLocationUpdate = CenterOnLocationUpdate.once;
    _centerCurrentLocationStreamController = StreamController<double?>();
  }

  @override
  Widget build(BuildContext context) {
    print('main_page(map) build called.');
    return Scaffold(
      // drawer: Menu(),
      // appBar: AppBar(
      //   title: Text('Map',
      //       style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
      //   backgroundColor: Colors.lightBlue,
      // ),
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
                  decenter;
                }
              },
            ),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate: '$kMapUrl?access_token=$kAccessToken',
                  maxZoom: 19,
                ),
              ),
              MarkerLayerWidget(
                options: MarkerLayerOptions(markers: markers),
              ),
              LocationMarkerLayerWidget(
                plugin: LocationMarkerPlugin(
                  centerCurrentLocationStream:
                      _centerCurrentLocationStreamController.stream,
                  centerOnLocationUpdate: _centerOnLocationUpdate,
                ),
              ),
              PolylineLayerWidget(
                options: PolylineLayerOptions(
                    polylines: DirectionsService.getPolylines()),
              ),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 280,
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

  void center() {
    // Automatically center the map on the location marker until user interacts with the map.
    setState(
      () => _centerOnLocationUpdate = CenterOnLocationUpdate.never,
    );
    // Center the the map on the location marker and zoom the map to level 18.
    _centerCurrentLocationStreamController.add(18);
  }

  void decenter() {
    // Decenter the map from the location marker.
    setState(
      () => _centerOnLocationUpdate = CenterOnLocationUpdate.never,
    );
  }
}
