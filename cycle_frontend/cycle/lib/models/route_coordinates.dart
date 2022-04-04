/// Class that parses the backend API response (the one using Tfl routing)
/// into a model, later used for routing. Not used in the scope of the project
/// due to Tfl responses being unreliable.
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
