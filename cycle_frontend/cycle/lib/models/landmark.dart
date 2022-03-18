class Landmark {
  String id;
  String name;
  double lat;
  double lon;

  Landmark(this.id, this.name, this.lat, this.lon);

  factory Landmark.fromJson(dynamic json) {
    return Landmark(
      json['id'] as String,
      json['name'] as String,
      json['lat'] as double,
      json['lon'] as double,
    );
  }
}
