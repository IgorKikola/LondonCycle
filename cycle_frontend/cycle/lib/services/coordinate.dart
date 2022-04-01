class Coordinate {
  double latitude;
  double longitude;
  String name;

  Coordinate(
      {required this.latitude, required this.longitude, required this.name});

  @override
  String toString() {
    return "lat: $latitude, long: $longitude, name: $name";
  }
}
