class MapBoxConfig {
  static const String mapBoxURL = 'api.mapbox.com';
  static const String mapBoxAPIKey =
      'pk.eyJ1IjoibWFyaWFuZ2FydHUiLCJhIjoiY2t6aWh3Yjg1MjZmNTJ1bzZudjQ3NW45NSJ9.LJQ8MpEySa-SINNUc8z9rQ';
  static const String mapBoxMapAPI =
      'https://$mapBoxURL/styles/v1/mariangartu/ckzjt4a9d000v14s451ltur5q/tiles/256/{z}/{x}/{y}@2x?access_token=$mapBoxAPIKey';
  static const String mapBoxRoutingAPI = '/directions/v5/mapbox/cycling/';
  static const String mapBoxGeocodingAPI = '/geocoding/v5/mapbox.places/';
}
