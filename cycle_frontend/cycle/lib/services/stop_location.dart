import '../models/named_lat_lng.dart';

enum StopType { midpoint }

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
