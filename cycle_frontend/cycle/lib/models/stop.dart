class Stop {
  int id;
  String name;
  double lat;
  double lon;

  Stop(this.id, this.name, this.lat, this.lon) {
    id = this.id;
    name = this.name;
    lat = this.lat;
    lon = this.lon;
  }

  toJson() {
    return {
      "id": id,
      "name": name,
      "lat": lat,
      "lon": lon
    };
  }

  fromJson(jsonData) {
    return Stop(
        jsonData['id'],
        jsonData['name'],
        jsonData['lat'],
        jsonData['lon']);
  }
  factory Stop.fromJson(dynamic json) {
    return Stop(
      json['id'] as int,
      json['name'] as String,
      json['lat'] as double,
      json['lon'] as double,
    );
  }
}
