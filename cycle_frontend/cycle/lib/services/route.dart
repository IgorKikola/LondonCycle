import 'coordinate.dart';

enum Waypoint { START, MIDPOINT, FINISH }

class MyRoute {
  Coordinate? startingLocation;
  Coordinate? finishingLocation;

  MyRoute();

  setStartingLocation(Coordinate location) {
    startingLocation = location;
  }

  setFinishingLocation(Coordinate location) {
    finishingLocation = location;
  }

  String getRouteAsSemicolonSeparatedListWithLongLatOrder() {
    String result =
        '${startingLocation!.longitude},${startingLocation!.latitude};${finishingLocation!.longitude},${finishingLocation!.latitude}';

    return result;
  }
}
