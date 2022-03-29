import 'package:cycle/models/docking_station.dart';
import 'package:cycle/models/journey_stop.dart';
import 'package:cycle/models/landmark.dart';
import 'package:cycle/models/stop.dart';
import 'package:cycle/services/network_helper.dart';
import 'package:latlong2/latlong.dart';

const String kBackEndUrl = 'https://agile-citadel-13372.herokuapp.com/';

const String kBikePointsPath = 'bikepoints/?format=json';
const String kClosestBikePointPath = 'closest/bikepoint';
const String kLandmarksPath = 'landmarks/?format=json';

Future<List<DockingStation>> getDockingStations() async {
  NetworkHelper networkHelper = NetworkHelper(kBackEndUrl + kBikePointsPath);

  List<DockingStation> dockingStations =
      (await networkHelper.getDataAsJsonList())
          .map((dockingStation) => DockingStation.fromJson(dockingStation))
          .toList();

  return dockingStations;
}

Future<DockingStation> getClosestDockingStationWithBikesAvailable(
    LatLng latLng, int numberOfBikes) async {
  NetworkHelper networkHelper = NetworkHelper(kBackEndUrl +
      kClosestBikePointPath +
      "/with/$numberOfBikes/bikes/from/${latLng.latitude}/${latLng.longitude}");

  print(kBackEndUrl +
      kClosestBikePointPath +
      "/with/$numberOfBikes/bikes/from/${latLng.latitude}/${latLng.longitude}");
  DockingStation dockingStation =
      DockingStation.fromJson(await networkHelper.getData());

  return dockingStation;
}

Future<DockingStation> getClosestDockingStationWithEmptyDocks(
    LatLng latLng, int numberOfBikes) async {
  NetworkHelper networkHelper = NetworkHelper(kBackEndUrl +
      kClosestBikePointPath +
      "/with/$numberOfBikes/empty_docks/from/${latLng.latitude}/${latLng.longitude}");

  DockingStation dockingStation =
      DockingStation.fromJson(await networkHelper.getData());

  return dockingStation;
}

Future<List<Landmark>> getLandmarks() async {
  NetworkHelper networkHelper = NetworkHelper(kBackEndUrl + kLandmarksPath);

  List<Landmark> landmarks = (await networkHelper.getDataAsJsonList())
      .map((landmark) => Landmark.fromJson(landmark))
      .toList();

  return landmarks;
}

Future<List<JourneyStop>> getStops() async {
  NetworkHelper networkHelper = NetworkHelper(kBackEndUrl + kLandmarksPath);

  List<JourneyStop> journeyStops = (await networkHelper.getDataAsJsonList())
      .map((journeyStop) => JourneyStop.fromJson(journeyStop))
      .toList();

  return journeyStops;
}
