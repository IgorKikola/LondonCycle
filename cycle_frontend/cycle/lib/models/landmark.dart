import 'package:cycle/models/place.dart';

class Landmark extends Place {
  Landmark(String id, String name, double lat, double lon)
      : super(id, name, lat, lon);

  factory Landmark.fromJson(dynamic json) {
    return Landmark(
      json['id'] as String,
      json['name'] as String,
      json['lat'] as double,
      json['lon'] as double,
    );
  }
}
