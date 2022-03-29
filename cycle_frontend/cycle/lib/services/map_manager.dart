import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

openMapsSheet(context, LatLng startLocation, LatLng endLocation,
    DirectionsMode directionsMode) async {
  try {
    final availableMaps = await MapLauncher.installedMaps;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () async => {
                        Navigator.pop(context),
                        await map.showDirections(
                            origin: Coords(startLocation.latitude,
                                startLocation.longitude),
                            destination: Coords(
                                endLocation.latitude, endLocation.longitude),
                            directionsMode: directionsMode)
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
          ),
        );
      },
    );
  } catch (e) {
    print(e);
  }
}
// onPressed: () => openMapsSheet(context),
