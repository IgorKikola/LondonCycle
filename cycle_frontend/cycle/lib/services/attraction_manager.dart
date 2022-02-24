import 'package:cycle/components/attraction_layer.dart';
import 'package:cycle/services/network_helper.dart';
import 'package:cycle/services/user_location_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import '../constants.dart';
import 'package:latlong2/latlong.dart';

/// This class is responsible for creating markers on the map of interesting locations
/// around the given Position and building a layer for displaying all the markers.
class AttractionManager {
  var url = "http://api.opentripmap.com/0.1/en/places/bbox?";

  AttractionManager();

  /// Retrieve a list of interesting locations to visit around the given position.
  Future<dynamic> getLocationsAroundPosition(Future<Position> position) async {
    // ======================
    // ERROR here
    // How to retrieve the Position object from the Future object?
    // It gets sent from the "getMarkersAroundUsersCurrentPosition" method.
    var newPosition;

    FutureBuilder<Position>(
      future: position,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          newPosition = snapshot.data;
        } else {
          newPosition = "";
        }
      },
    );
    // ======================

    double latitude = newPosition.latitude;
    double longitude = newPosition.longitude;

    // Build a URL for an API which returns interesting locations
    // according to the provided coordinates.
    url +=
        "lon_min=${longitude - 0.01}&lat_min=${latitude - 0.01}&lon_max=${longitude + 0.01}&lat_max=${latitude + 0.01}"
        "&kinds=interesting_places&format=geojson&apikey=$kOpenTripMapAPIKey";

    // Use NetworkHelper to retrieve JSON data and decode it.
    final networkHelper = NetworkHelper(url);
    dynamic featureCollection = await networkHelper.getData();

    // Extract a list of 'features' discarding all the other data
    // in the decoded JSON.
    return featureCollection['features'];
  }

  Future<List<Marker>> getMarkersAroundUsersCurrentPosition() async {
    // Retrieve a list of locations around the users current location
    // For that the global getPosition() method is passed which returns
    // a Future<Position>.
    List<dynamic> locations = await getLocationsAroundPosition(getPosition());

    // For each of the locations, create a marker to use in the Map.
    List<Marker> markers = <Marker>[];
    for (dynamic location in locations) {
      markers.add(
        Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(
            location['geometry']['coordinates'][1],
            location['geometry']['coordinates'][0],
          ),
          builder: (context) => Tooltip(
            child: const Icon(
              Icons.account_balance,
              color: Color(0xFFFFC43D),
            ),
            message: '${location['properties']['name']}',
          ),
        ),
      );
    }

    return markers;
  }

  FutureBuilder getAttractionLayerWithMarkersAroundUsersCurrentPosition() {
    // Build an attraction layer which contains all the necessary markers.
    Future<List<Marker>> markersFuture = getMarkersAroundUsersCurrentPosition();
    return FutureBuilder<List<Marker>>(
      future: markersFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AttractionLayer(markers: snapshot.data!);
        } else {
          return const AttractionLayer(markers: []);
        }
      },
    );
  }

  // Future<AttractionLayer>
  //     getAttractionLayerWithMarkersAroundUsersCurrentPosition() async {
  //   List<Marker> markers = await getMarkersAroundUsersCurrentPosition();
  //   return AttractionLayer(markers: markers);
  // }
}
