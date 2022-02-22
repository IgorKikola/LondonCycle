import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/services/locations_manager.dart';

class PlacesLayer extends StatelessWidget {
  final double latitude;
  final double longitude;

  PlacesLayer({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Marker>>(
      future: getMarkers(),
      builder: (BuildContext context, AsyncSnapshot<List<Marker>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print(
            "It is loading.",
          );
          return Container();
        } else {
          if (snapshot.hasError) {
            print(
              "An error occurred while trying to get markers of interesting places to visit.",
            );
            return Container();
          } else {
            return MarkerLayerWidget(
              options: MarkerLayerOptions(
                markers: snapshot.data!,
              ),
            );
          }
        }
      },
    );
  }

  Future<List<Marker>> getMarkers() async {
    LocationsManager locationsManager = LocationsManager();
    List<dynamic> locations = await locationsManager
        .getAttractionsAroundLocation(latitude, longitude);

    List<Marker> markers = <Marker>[];
    for (dynamic location in locations) {
      markers.add(Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(
          location['geometry']['coordinates'][1],
          location['geometry']['coordinates'][0],
        ),
        builder: (context) => Container(
          child: Tooltip(
            child: const Icon(
              Icons.account_balance,
              color: Color(0xFFFFC43D),
            ),
            message: '${location['properties']['name']}',
          ),
        ),
      ));
    }

    return markers;
  }
}
