import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MapManager {
  dynamic context;

  MapManager(this.context);

  Future<void> openMapsSheet(LatLng startLocation, LatLng endLocation,
      DirectionsMode directionsMode) async {
    try {
      final availableMaps = await MapLauncher.installedMaps;
      await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () async {
                        await map.showDirections(
                            origin: Coords(startLocation.latitude,
                                startLocation.longitude),
                            destination: Coords(
                                endLocation.latitude, endLocation.longitude),
                            directionsMode: directionsMode);

                        showAlert(context);
                      },
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      // print(e);
    }
  }

  Future<void> showAlert(context) async {
    Alert(
      context: context,
      type: AlertType.info,
      title: "HOORAY",
      desc: "Let's continue your journey",
      buttons: [
        DialogButton(
          child: const Text(
            "Continue",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          color: const Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }
}
