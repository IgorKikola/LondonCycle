import 'coordinate.dart';

enum MarkerType { START, FINISH }

class MarkerLocation {
  static Coordinate startingLocation =
      Coordinate(latitude: 0.0, longitude: 0.0);
  static Coordinate endingLocation = Coordinate(latitude: 0.0, longitude: 0.0);

  MarkerLocation();

  void setStartingLocation(Coordinate start) {
    startingLocation = start;
  }

  void setEndingLocation(Coordinate end) {
    endingLocation = end;
  }

  Coordinate getStartingLocation() {
    return startingLocation;
  }

  Coordinate getEndingLocation() {
    return endingLocation;
  }
}
