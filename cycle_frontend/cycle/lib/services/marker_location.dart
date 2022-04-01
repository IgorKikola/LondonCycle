import 'coordinate.dart';

enum MarkerType { START, FINISH }

class MarkerLocation {
  static NamedLatLng startingLocation =
      NamedLatLng(latitude: 0.0, longitude: 0.0, name: '');
  static NamedLatLng destination =
      NamedLatLng(latitude: 0.0, longitude: 0.0, name: '');

  MarkerLocation();

  void setStartingLocation(NamedLatLng start) {
    startingLocation = start;
  }

  void setDestination(NamedLatLng end) {
    destination = end;
  }

  NamedLatLng getStartingLocation() {
    return startingLocation;
  }

  NamedLatLng getDestination() {
    return destination;
  }
}
