class DockingStation {
  String id;
  String name;
  double lat;
  double lon;

  DockingStation(this.id, this.name, this.lat, this.lon);

  factory DockingStation.fromJson(dynamic json) {
    return DockingStation(
      json['id'] as String,
      json['name'] as String,
      json['lat'] as double,
      json['lon'] as double,
    );
  }
}
