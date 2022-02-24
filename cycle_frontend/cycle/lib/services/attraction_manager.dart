import 'package:cycle/components/attraction_layer.dart';
import 'package:cycle/services/network_helper.dart';
import 'package:cycle/services/user_location_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import '../constants.dart';
import 'package:latlong2/latlong.dart';

/// This class is responsible for returning a list of locations based on the provided coordinates.
class AttractionManager {
  var url = "http://api.opentripmap.com/0.1/en/places/bbox?";

  AttractionManager();

  Future<dynamic> getLocationsAroundPosition(Future<Position> position) async {
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

    double latitude = newPosition.latitude;
    double longitude = newPosition.longitude;

    url +=
        "lon_min=${longitude - 0.01}&lat_min=${latitude - 0.01}&lon_max=${longitude + 0.01}&lat_max=${latitude + 0.01}"
        "&kinds=interesting_places&format=geojson&apikey=$kOpenTripMapAPIKey";

    final networkHelper = NetworkHelper(url);
    dynamic featureCollection = await networkHelper.getData();
    return featureCollection['features'];
  }

  Future<List<Marker>> getMarkersAroundUsersCurrentPosition() async {
    List<dynamic> locations = await getLocationsAroundPosition(getPosition());

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
