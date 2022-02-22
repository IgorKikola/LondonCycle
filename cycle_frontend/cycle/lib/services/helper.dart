import 'package:cycle/services/user_location_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

class Helper {
  double usersLatitude;
  double usersLongitude;
  List<Marker> markers;

  Helper(this.usersLatitude, this.usersLongitude, this.markers);

  void updateMarkers() async {
    Position position = await getPosition();
  }
}
