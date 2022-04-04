import '../models/named_lat_lng.dart';

/// Class that sets and displays the search marker on the map
enum MarkerType { start, finish }

class MarkerLocation {
  static NamedLatLng startingLocation =
      NamedLatLng(latitude: 0.0, longitude: 0.0, name: '');
  static NamedLatLng destination =
      NamedLatLng(latitude: 0.0, longitude: 0.0, name: '');

  MarkerLocation();

  ///Method that sets the starting location of the marker
  void setStartingLocation(NamedLatLng start) {
    startingLocation = start;
  }

  ///Method that sets the destination of the marker
  void setDestination(NamedLatLng end) {
    destination = end;
  }

  ///Method that returns the starting location of the marker
  NamedLatLng getStartingLocation() {
    return startingLocation;
  }

  ///Method that returns the destination of the marker
  NamedLatLng getDestination() {
    return destination;
  }
}
