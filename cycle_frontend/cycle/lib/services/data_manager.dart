import 'package:cycle/models/docking_station.dart';
import 'package:cycle/services/network_helper.dart';

const String kBackEndUrl = 'https://agile-citadel-13372.herokuapp.com/';

const String kBikePointsPath = 'bikepoints/?format=json';

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
