import 'coordinate.dart';

enum MarkerType { START, FINISH }

class MarkerLocation {
  static Coordinate startingLocation =
      Coordinate(latitude: 0.0, longitude: 0.0, name: '');
  static Coordinate destination =
      Coordinate(latitude: 0.0, longitude: 0.0, name: '');

  MarkerLocation();

  void setStartingLocation(Coordinate start) {
    startingLocation = start;
  }

  void setDestination(Coordinate end) {
    destination = end;
  }

  Coordinate getStartingLocation() {
    return startingLocation;
  }

  Coordinate getDestination() {
    return destination;
  }
}
