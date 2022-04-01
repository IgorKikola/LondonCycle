import 'coordinate.dart';

enum Waypoint { START, MIDPOINT, FINISH }

class MyRoute {
  Coordinate? startingLocation;
  Coordinate? finishingLocation;
  List<Coordinate> waypoints = List.empty(growable: true);

  MyRoute();

  setStartingLocation(Coordinate location) {
    startingLocation = location;
  }

  setFinishingLocation(Coordinate location) {
    finishingLocation = location;
  }

  addWaypoint(Coordinate location) {
    waypoints.add(location);
  }

  removeWaypointAt(int index) {
    if (index >= 0 && index < waypoints.length) {
      waypoints.removeAt(index);
    }
  }

  String getRouteAsSemicolonSeparatedListWithLongLatOrder() {
    String startingLocationFormatted =
        '${startingLocation!.longitude},${startingLocation!.latitude}';
    String finishingLocationFormatted =
        '${finishingLocation!.longitude},${finishingLocation!.latitude}';
    String waypointsFormatted = getFormattedWaypoints();

    String result =
        '$startingLocationFormatted;$waypointsFormatted$finishingLocationFormatted';

    return result;
  }

  List<Coordinate> getRouteAsList() {
    List<Coordinate> routeAsList = List.from(waypoints);
    routeAsList.insert(0, startingLocation!);
    routeAsList.add(finishingLocation!);
    return routeAsList;
  }

  String getFormattedWaypoints() {
    String waypointsFormatted = '';
    if (waypoints.isNotEmpty) {
      for (int i = 0; i < waypoints.length; i++) {
        String waypointLongitude = waypoints.elementAt(i).longitude.toString();
        String waypointLatitude = waypoints.elementAt(i).latitude.toString();
        waypointsFormatted = waypointsFormatted +
            waypointLongitude +
            ',' +
            waypointLatitude +
            ';';
      }
    }
    return waypointsFormatted;
  }

  String getFormattedWaypointsLatLongOrder() {
    String waypointsFormatted = '';
    if (waypoints.isNotEmpty) {
      for (int i = 0; i < waypoints.length; i++) {
        String waypointLatitude = waypoints.elementAt(i).latitude.toString();
        String waypointLongitude = waypoints.elementAt(i).longitude.toString();

        waypointsFormatted = waypointsFormatted +
            waypointLatitude +
            ',' +
            waypointLongitude +
            ';';
      }
      waypointsFormatted =
          waypointsFormatted.substring(0, waypointsFormatted.length - 2);
    }
    return waypointsFormatted;
  }
}
