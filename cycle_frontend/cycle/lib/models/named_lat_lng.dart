import 'package:latlong2/latlong.dart';

/// Extension of the LatLng class, which includes name to help identify the location.
class NamedLatLng extends LatLng {
  String name;

  NamedLatLng({required latitude, required longitude, required this.name})
      : super(latitude, longitude);

  @override
  String toString() {
    return "lat: $latitude, long: $longitude, name: $name";
  }
}
