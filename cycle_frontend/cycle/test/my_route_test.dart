import 'package:cycle/models/named_lat_lng.dart';
import 'package:cycle/services/my_route.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MyRoute object test.', () {
    MyRoute myRoute = MyRoute();

    var actualStartingLocation = myRoute.startingLocation;
    var actualFinishingLocation = myRoute.finishingLocation;

    int actualNumberOfRiders = myRoute.numOfRiders;
    List<NamedLatLng> actualWaypoints = myRoute.waypoints;
    expect(actualStartingLocation, null);
    expect(actualFinishingLocation, null);
    expect(actualNumberOfRiders, 1);
    expect(actualWaypoints, List.empty(growable: true));
  });

  test('MyRoute setters test.', () {
    MyRoute myRoute = MyRoute();
    myRoute.setStartingLocation(
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start'));
    myRoute.setFinishingLocation(
        NamedLatLng(latitude: -1.0, longitude: -2.0, name: 'finish'));

    double actualStartLat = myRoute.startingLocation!.latitude;
    double actualStartLon = myRoute.startingLocation!.longitude;
    String actualStartName = myRoute.startingLocation!.name;
    double actualFinishLat = myRoute.finishingLocation!.latitude;
    double actualFinishLon = myRoute.finishingLocation!.longitude;
    String actualFinishName = myRoute.finishingLocation!.name;
    expect(actualStartLat, 0.0);
    expect(actualStartLon, 1.0);
    expect(actualStartName, 'start');
    expect(actualFinishLat, -1.0);
    expect(actualFinishLon, -2.0);
    expect(actualFinishName, 'finish');
  });

  test('MyRoute adding waypoint test.', () {
    MyRoute myRoute = MyRoute();
    int actualStartingWaypointsLength = myRoute.waypoints.length;
    expect(actualStartingWaypointsLength, 0);

    myRoute.addWaypoint(
        NamedLatLng(latitude: 2.0, longitude: 3.0, name: 'waypoint1'));
    int actualEndingWaypointsLength = myRoute.waypoints.length;
    double actualWaypointLat = myRoute.waypoints.first.latitude;
    double actualWaypointLon = myRoute.waypoints.first.longitude;
    String actualWaypointName = myRoute.waypoints.first.name;
    expect(actualEndingWaypointsLength, 1);
    expect(actualWaypointLat, 2.0);
    expect(actualWaypointLon, 3.0);
    expect(actualWaypointName, 'waypoint1');
  });

  test('MyRoute removing waypoint test.', () {
    MyRoute myRoute = MyRoute();

    myRoute.addWaypoint(
        NamedLatLng(latitude: 2.0, longitude: 3.0, name: 'waypoint1'));
    int actualStartingWaypointsLength = myRoute.waypoints.length;
    expect(actualStartingWaypointsLength, 1);

    myRoute.removeWaypointAt(0);

    int actualEndingWaypointsLength = myRoute.waypoints.length;
    expect(actualEndingWaypointsLength, 0);
  });

  test('MyRoute isRouteComplete positive test.', () {
    MyRoute myRoute = MyRoute();
    myRoute.setStartingLocation(
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start'));
    myRoute.setFinishingLocation(
        NamedLatLng(latitude: -1.0, longitude: -2.0, name: 'finish'));

    bool actualIsRouteComplete = myRoute.isRouteComplete();
    expect(actualIsRouteComplete, true);
  });

  test('MyRoute isRouteComplete negative1 test.', () {
    MyRoute myRoute = MyRoute();

    bool actualIsRouteComplete = myRoute.isRouteComplete();
    expect(actualIsRouteComplete, false);
  });

  test('MyRoute isRouteComplete negative2 test.', () {
    MyRoute myRoute = MyRoute();
    myRoute.setStartingLocation(
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start'));

    bool actualIsRouteComplete = myRoute.isRouteComplete();
    expect(actualIsRouteComplete, false);
  });

  test('MyRoute getRouteAsSemicolonSeparatedListWithLongLatOrder test.', () {
    MyRoute myRoute = MyRoute();
    myRoute.setStartingLocation(
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start'));
    myRoute.setFinishingLocation(
        NamedLatLng(latitude: -1.0, longitude: -2.0, name: 'finish'));

    myRoute.addWaypoint(
        NamedLatLng(latitude: 2.0, longitude: 3.0, name: 'waypoint1'));
    myRoute.addWaypoint(
        NamedLatLng(latitude: 4.0, longitude: 5.0, name: 'waypoint2'));

    String actualString =
        myRoute.getRouteAsSemicolonSeparatedListWithLongLatOrder();
    String expectedString = '1.0,0.0;3.0,2.0;5.0,4.0;-2.0,-1.0';

    expect(actualString, expectedString);
  });

  test('MyRoute getRouteAsList test.', () {
    MyRoute myRoute = MyRoute();

    NamedLatLng firstLocation =
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start');
    NamedLatLng secondLocation =
        NamedLatLng(latitude: 2.0, longitude: 3.0, name: 'waypoint1');
    NamedLatLng thirdLocation =
        NamedLatLng(latitude: 4.0, longitude: 5.0, name: 'waypoint2');
    NamedLatLng fourthLocation =
        NamedLatLng(latitude: -1.0, longitude: -2.0, name: 'finish');

    myRoute.setStartingLocation(firstLocation);
    myRoute.setFinishingLocation(fourthLocation);

    myRoute.addWaypoint(secondLocation);
    myRoute.addWaypoint(thirdLocation);

    NamedLatLng actualFirstLocation = myRoute.getRouteAsList().elementAt(0);
    NamedLatLng actualSecondLocation = myRoute.getRouteAsList().elementAt(1);
    NamedLatLng actualThirdLocation = myRoute.getRouteAsList().elementAt(2);
    NamedLatLng actualFourthLocation = myRoute.getRouteAsList().elementAt(3);

    int actualEndingListLength = myRoute.getRouteAsList().length;

    expect(actualFirstLocation, firstLocation);
    expect(actualSecondLocation, secondLocation);
    expect(actualThirdLocation, thirdLocation);
    expect(actualFourthLocation, fourthLocation);
    expect(actualEndingListLength, 4);
  });

  test('MyRoute getFormattedWaypoints test.', () {
    MyRoute myRoute = MyRoute();
    myRoute.setStartingLocation(
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start'));
    myRoute.setFinishingLocation(
        NamedLatLng(latitude: -1.0, longitude: -2.0, name: 'finish'));

    myRoute.addWaypoint(
        NamedLatLng(latitude: 2.0, longitude: 3.0, name: 'waypoint1'));
    myRoute.addWaypoint(
        NamedLatLng(latitude: 4.0, longitude: 5.0, name: 'waypoint2'));

    String actualString = myRoute.getFormattedWaypoints();
    String expectedString = '3.0,2.0;5.0,4.0;';

    expect(actualString, expectedString);
  });

  test('MyRoute getFormattedWaypointsLatLongOrder test.', () {
    MyRoute myRoute = MyRoute();
    myRoute.setStartingLocation(
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start'));
    myRoute.setFinishingLocation(
        NamedLatLng(latitude: -1.0, longitude: -2.0, name: 'finish'));

    myRoute.addWaypoint(
        NamedLatLng(latitude: 2.0, longitude: 3.0, name: 'waypoint1'));
    myRoute.addWaypoint(
        NamedLatLng(latitude: 4.0, longitude: 5.0, name: 'waypoint2'));

    String actualString = myRoute.getFormattedWaypointsLatLongOrder();
    String expectedString = '2.0,3.0;4.0,5.0';

    expect(actualString, expectedString);
  });
}
