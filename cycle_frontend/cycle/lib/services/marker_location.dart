import 'coordinate.dart';

enum MarkerType { START, FINISH }

class MarkerLocation {
  static Coordinate startingLocation =
      Coordinate(latitude: 51.50, longitude: 0.12);
  static Coordinate destination = Coordinate(latitude: 51.50, longitude: -0.11);

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
