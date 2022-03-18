import 'package:cycle/models/docking_station.dart';
import 'package:cycle/models/landmark.dart';
import 'package:cycle/services/network_helper.dart';

const String kBackEndUrl = 'https://agile-citadel-13372.herokuapp.com/';

const String kBikePointsPath = 'bikepoints/?format=json';
const String kLandmarksPath = 'landmarks/?format=json';

Future<List<DockingStation>> getDockingStations() async {
  NetworkHelper networkHelper = NetworkHelper(kBackEndUrl + kBikePointsPath);
  var dockingStationsAsJson = (await networkHelper.getData());

  if (dockingStationsAsJson == null) {
    return List.empty();
  }

  var dockingStationsAsJsonList = dockingStationsAsJson['results'] as List;

  List<DockingStation> dockingStations = dockingStationsAsJsonList
      .map((dockingStation) => DockingStation.fromJson(dockingStation))
      .toList();
  return dockingStations;
}

Future<List<Landmark>> getLandmarks() async {
  NetworkHelper networkHelper = NetworkHelper(kBackEndUrl + kLandmarksPath);
  var landmarksAsJson = (await networkHelper.getData());

  if (landmarksAsJson == null) {
    return List.empty();
  }

  var landmarksAsJsonList = landmarksAsJson['results'] as List;

  List<Landmark> landmarks = landmarksAsJsonList
      .map((landmark) => Landmark.fromJson(landmark))
      .toList();
  return landmarks;
}
