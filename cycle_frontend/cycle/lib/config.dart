class Config {
  static const String apiURL = "agile-citadel-13372.herokuapp.com";
  static const String fullApiURL = "https://$apiURL/";
  static const String loginAPI = "/login/";
  static const String signupAPI = "/signup/";
  static const String getUserProfileAPI = "/users/get/";
  static const String updateUserProfileAPI = "/users/update/";

  static const String fiveClosestLandmarksAPI = '/closest/5/landmarks/from/';
  static const String fiveClosestBikePointsAPI = '/closest/5/bikepoints/from/';
  static const String stopsAPI = '/stops/';
  static const String stopsURL = 'https://$apiURL$stopsAPI?format=json';
  static const String bikePointsAPI = 'bikepoints/?format=json';
  static const String closestBikePointAPI = 'closest/bikepoint';
  static const String landmarksAPI = 'landmarks/?format=json';
  static const String routingAPI = 'get_route/';
  static const String routingMultipleStopsAPI = 'get_route_multiple_stop/';
  static const String routingSingleStopAPI = 'get_route_single_stop/';

  static const String mapBoxURL = 'api.mapbox.com';
  static const String mapBoxAPIKey =
      'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';

  static const String mapBoxMapAPI =
      'https://${Config.mapBoxURL}/styles/v1/mariangartu/ckzjt4a9d000v14s451ltur5q/tiles/256/{z}/{x}/{y}@2x?access_token=${Config.mapBoxAPIKey}';
  static const String mapBoxRoutingAPI = '/directions/v5/mapbox/cycling/';
  static const String mapBoxGeocodingAPI = '/geocoding/v5/mapbox.places/';
}
