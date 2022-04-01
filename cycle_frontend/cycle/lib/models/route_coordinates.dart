class RouteCoordinates {
  late List<dynamic> coordinatesList;

  RouteCoordinates({
    required this.coordinatesList,
  });

  factory RouteCoordinates.fromJson(parsedJson) {
    var coordinatesFromJson = parsedJson;

    return RouteCoordinates(
      coordinatesList: coordinatesFromJson,
    );
  }
}
