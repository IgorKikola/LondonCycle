import 'dart:async';
import 'package:cycle/services/data_managers/bikepoint_data_manager.dart';
import 'package:cycle/services/location_manager.dart';
import 'package:cycle/services/mapcontroller_provider.dart';
import 'package:cycle/services/marker_manager.dart';
import 'package:cycle/services/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import '../services/mapcontroller_provider.dart';
import '../services/marker_location.dart';
import '../services/routing.dart';
import '../utilities/map_box_config.dart';

/// The page containing the map.
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

///Map widget that displays landmarks and bikepoints as markers. It also has several
///buttons to center, zoom-in, and zoom-out.
class MapWidget extends StatefulWidget {
  const MapWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  List<Marker> markers = [];
  MarkerLocation searchMarker = MarkerLocation();
  MapController mapController = MapControllerProvider.mapController;

  void _myMapWidgetRefresh() {
    setState(() {});
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
    markers = await loadLandmarkMarkers() + await loadDockingStationMarkers();
  }

  Future<List<Marker>> loadDockingStationMarkers() async {
    return (await getDockingStations())
        .map((dockingStation) => getDockingStationMarker(dockingStation))
        .toList();
  }

  Future<List<Marker>> loadLandmarkMarkers() async {
    return (await getLandmarks())
        .map((landmark) => getLandmarkMarker(landmark))
        .toList();
  }

  void initUserLocationMarker() {
    _centerOnLocationUpdate = CenterOnLocationUpdate.once;
    _centerCurrentLocationStreamController = StreamController<double?>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
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
                  urlTemplate: MapBoxConfig.mapBoxMapAPI,
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
                    polylines: RoutingService.getPolylines()),
              ),
            ],
            layers: [
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(searchMarker.getStartingLocation().latitude,
                        searchMarker.getStartingLocation().longitude),
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.location_on),
                      color: Colors.red[900],
                      iconSize: 50.0,
                      onPressed: () {},
                    ),
                  ),
                  Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(searchMarker.getDestination().latitude,
                        searchMarker.getDestination().longitude),
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.location_on),
                      color: Colors.blue[900],
                      iconSize: 50.0,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 280,
            child: FloatingActionButton.small(
              backgroundColor: Colors.blue,
              onPressed: center,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 330,
            child: FloatingActionButton.small(
              heroTag: 'move_to_start',
              backgroundColor: Colors.blue,
              onPressed: moveToStart,
              child: const Icon(
                Icons.pin_drop,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 380,
            child: FloatingActionButton.small(
              heroTag: 'move_to_destination',
              backgroundColor: Colors.blue,
              onPressed: moveToDestination,
              child: const Icon(
                Icons.sports_score,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 430,
            child: FloatingActionButton.small(
              heroTag: 'zoom_in',
              backgroundColor: Colors.blue,
              onPressed: zoomIn,
              child: const Icon(
                Icons.zoom_in,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 480,
            child: FloatingActionButton.small(
              heroTag: 'zoom_out',
              backgroundColor: Colors.blue,
              onPressed: zoomOut,
              child: const Icon(
                Icons.zoom_out,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Method to dynamically update the markers position
  void adjustMarker() {
    setState(() {
      searchMarker.getStartingLocation();
      searchMarker.getDestination();
    });
  }

  ///Method to pan the map to the destination marker based on user input.
  void moveToDestination() {
    setState(() {
      if (searchMarker.getDestination().latitude != 0.0) {
        mapController.move(
            LatLng(searchMarker.getDestination().latitude,
                searchMarker.getDestination().longitude),
            13);
      }
    });
  }

  ///Method to pan the map to the starting location marker based on user input.
  void moveToStart() {
    setState(() {
      if (searchMarker.getStartingLocation().latitude != 0.0) {
        mapController.move(
            LatLng(searchMarker.getStartingLocation().latitude,
                searchMarker.getStartingLocation().longitude),
            13);
      }
    });
  }

  ///Utility button to zoom in with one level of precision on the map
  void zoomIn() {
    setState(() {
      mapController.move(mapController.center, (mapController.zoom + 1));
    });
  }

  ///Utility button to zoom out with one level of precision on the map
  void zoomOut() {
    setState(() {
      mapController.move(mapController.center, (mapController.zoom - 1));
    });
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
