
class MapBoxRoute {
  late Geometry geometry;

  MapBoxRoute({
    required this.geometry,
  });

  factory MapBoxRoute.fromJson(Map<String, dynamic> parsedJson) {
    return MapBoxRoute(
      geometry: Geometry.fromJson(parsedJson['routes'][0]),
    );
  }
}

class Geometry {
  late Coordinates coordinates;

  Geometry({
    required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> parsedJson) {
    return Geometry(
      coordinates: Coordinates.fromJson(parsedJson['geometry']),
    );
  }
}

class Coordinates {
  late List<List<dynamic>> coordinatesList;

  Coordinates({
    required this.coordinatesList,
  });

  factory Coordinates.fromJson(Map<String, dynamic> parsedJson) {
    var coordinatesFromJson = parsedJson['coordinates'];
    List<List<dynamic>> coordinatesList =
        List<List<dynamic>>.from(coordinatesFromJson);

    return Coordinates(
      coordinatesList: coordinatesList,
    );
  }
}
