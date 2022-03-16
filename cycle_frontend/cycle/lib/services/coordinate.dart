class Coordinate {
  double latitude;
  double longitude;

  Coordinate({required this.latitude, required this.longitude});

  @override
  String toString() {
    return "lat: $latitude, long: $longitude";
  }
}
