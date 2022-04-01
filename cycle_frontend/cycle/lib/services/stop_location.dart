import 'coordinate.dart';

enum StopType { MIDPOINT }

class StopLocation {
  static NamedLatLng stopLocation =
      NamedLatLng(latitude: 0.0, longitude: 0.0, name: '');

  StopLocation();

  void setStopLocation(NamedLatLng midpoint) {
    stopLocation = midpoint;
  }

  NamedLatLng getStopLocation() {
    return stopLocation;
  }
}
