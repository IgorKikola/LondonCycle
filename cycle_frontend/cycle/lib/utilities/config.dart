class Config {
  static const String localhostURL = "localhost:8000";
  static const String fullApiURL = "https://$backendURL/";
  static const String backendURL = 'agile-citadel-13372.herokuapp.com';
  static const String stopsURL = 'https://$backendURL$stopsPath?format=json';
  static const String stopsPath = '/stops/';
  static const String loginPath = "/login/";
  static const String signupPath = "/signup/";
  static const String getUserProfilePath = "/users/get/";
  static const String updateUserProfilePath = "/users/update/";
  static const String bikePointsPath = '/bikepoints/?format=json';
  static const String closestBikePointPath = '/closest/bikepoint';
  static const String landmarksPath = '/landmarks/?format=json';
  static const String fiveClosestLandmarksPath = '/closest/5/landmarks/from/';
  static const String fiveClosestBikePointsPath = '/closest/5/bikepoints/from/';
  static const String routingPath = 'get_route/';
  static const String routingMultipleStopsPath = 'get_route_multiple_stop/';
  static const String routingSingleStopPath = 'get_route_single_stop/';
}
