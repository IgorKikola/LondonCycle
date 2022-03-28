/*

class Direction {
  late int id;
  // String studentName;
  // int studentScores;

  Direction({
    required this.id,
    // required this.studentName,
    // required this.studentScores
  });

  // Student.fromJson(Map<String, dynamic> parsedJson) {
  //   _id = parsedJson['id'];
  //   // _id = parsedJson['id'];
  //   // _title = parsedJson['title'];
  //   // _body = parsedJson['body'];
  // }

  // int get id => id1;

  factory Direction.fromJson(Map<String, dynamic> parsedJson) {
    return Direction(
      id: parsedJson['id'],
      // studentName: parsedJson['name'],
      // studentScores: parsedJson['score']
    );
  }
}
*/

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
