import 'package:cycle/models/place.dart';

class DockingStation extends Place {
  DockingStation(String id, String name, double lat, double lon)
      : super(id, name, lat, lon);

  factory DockingStation.fromJson(dynamic json) {
    return DockingStation(
      json['id'] as String,
      json['name'] as String,
      json['lat'] as double,
      json['lon'] as double,
    );
  }
}
