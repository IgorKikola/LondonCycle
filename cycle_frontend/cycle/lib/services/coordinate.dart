import 'package:latlng/latlng.dart';

class NamedLatLng extends LatLng {
  String name;

  NamedLatLng({required latitude, required longitude, required this.name})
      : super(latitude, longitude);

  @override
  String toString() {
    return "lat: $latitude, long: $longitude, name: $name";
  }
}
