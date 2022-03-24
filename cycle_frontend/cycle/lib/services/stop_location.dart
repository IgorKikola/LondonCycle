import 'coordinate.dart';

enum StopType { MIDPOINT }

class StopLocation {
  static Coordinate stopLocation = Coordinate(latitude: 0.0, longitude: 0.0);

  StopLocation();

  void setStopLocation(Coordinate midpoint) {
    stopLocation = midpoint;
  }

  Coordinate getStopLocation() {
    return stopLocation;
  }
}

