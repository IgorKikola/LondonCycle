class JourneyStop {
  int id;
  String name;
  double lat;
  double lon;

  JourneyStop({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
  });

  factory JourneyStop.fromJson(Map<String, dynamic> json) {
    return JourneyStop(
        id: json['id'], name: json['name'], lat: json['lat'], lon: json['lon']);
  }
  dynamic toJson() => {'id': id, 'name': name, 'lat': lat, 'lon': lon};
}
