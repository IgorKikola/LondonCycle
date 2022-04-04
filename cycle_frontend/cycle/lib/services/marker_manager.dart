import 'package:cycle/models/docking_station.dart';
import 'package:cycle/models/landmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

Marker getMarker(LatLng point, Icon icon) {
  return Marker(
    point: point,
    builder: (ctx) => icon,
  );
}

Marker getLandmarkMarker(Landmark landmark) {
  return getMarker(
      LatLng(landmark.lat, landmark.lon),
      const Icon(
        Icons.push_pin,
        color: Colors.amber,
      ));
}

Marker getDockingStationMarker(DockingStation dockingStation) {
  return getMarker(
      LatLng(dockingStation.lat, dockingStation.lon),
      const Icon(
        Icons.pedal_bike,
        color: Colors.blue,
        size: 15,
      ));
}
