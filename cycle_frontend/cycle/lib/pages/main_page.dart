import 'dart:async';

import 'package:cycle/services/attraction_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/services/user_location_manager.dart';
import 'package:cycle/pages/menu.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/attraction_layer.dart';

const String kMapUrl =
    'https://api.mapbox.com/styles/v1/mariangartu/ckzjt4a9d000v14s451ltur5q/tiles/256/{z}/{x}/{y}@2x';
const String kAccessToken =
    'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final UserLocationManager _locationManager = UserLocationManager();
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;

  @override
  void initState() {
    super.initState();
    _centerOnLocationUpdate = CenterOnLocationUpdate.always;
    _centerCurrentLocationStreamController = StreamController<double?>();
    _locationManager.run().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    _centerCurrentLocationStreamController.close();
    _locationManager.setStopped();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Menu(),
      // appBar: AppBar(
      //   title: Text('Map',
      //       style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
      //   backgroundColor: Colors.lightBlue,
      // ),
      body: Stack(
        children: [
          Map(
              centerCurrentLocationStreamController:
                  _centerCurrentLocationStreamController,
              centerOnLocationUpdate: _centerOnLocationUpdate,
              action: () => setState(
                    () =>
                        _centerOnLocationUpdate = CenterOnLocationUpdate.never,
                  )),
          Positioned(
            right: 10,
            bottom: 260,
            child: FloatingActionButton(
              onPressed: () async {
                // Automatically center the location marker on the map when location updated until user interact with the map.
                setState(
                  () => _centerOnLocationUpdate = CenterOnLocationUpdate.always,
                );
                // Center the location marker on the map and zoom the map to level 18.
                _centerCurrentLocationStreamController.add(18);
              },
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

class Map extends StatelessWidget {
  Map({
    Key? key,
    required StreamController<double?> centerCurrentLocationStreamController,
    required CenterOnLocationUpdate centerOnLocationUpdate,
    required this.action,
  })  : _centerCurrentLocationStreamController =
            centerCurrentLocationStreamController,
        _centerOnLocationUpdate = centerOnLocationUpdate,
        super(key: key);

  final StreamController<double?> _centerCurrentLocationStreamController;
  final CenterOnLocationUpdate _centerOnLocationUpdate;
  final Function action;
  final AttractionManager _attractionManager = AttractionManager();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.50, 0.12),
        zoom: 13,
        maxZoom: 19,
        // Stop centering the location marker on the map if user interacted with the map.
        onPositionChanged: (MapPosition position, bool hasGesture) {
          if (hasGesture) {
            action();
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
        LocationMarkerLayerWidget(
          plugin: LocationMarkerPlugin(
            centerCurrentLocationStream:
                _centerCurrentLocationStreamController.stream,
            centerOnLocationUpdate: _centerOnLocationUpdate,
          ),
        ),
        _attractionManager
            .getAttractionLayerWithMarkersAroundUsersCurrentPosition(),
      ],
    );
  }
}
