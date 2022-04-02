class MapBoxConfig {
  static const String mapBoxURL = 'api.mapbox.com';
  static const String mapBoxAPIKey =
      'pk.eyJ1IjoiZ2FydHVtYXJpYW4iLCJhIjoiY2wxaTRic2hjMGZzcjNjbWoyejN0eXNpbCJ9.mmBmmHl0m43vyKqH3vw-hg';
  static const String mapBoxMapAPI =
      'https://$mapBoxURL/styles/v1/gartumarian/cl1i4i6xa002e15o93ktpssyh/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ2FydHVtYXJpYW4iLCJhIjoiY2wxaTRic2hjMGZzcjNjbWoyejN0eXNpbCJ9.mmBmmHl0m43vyKqH3vw-hg';
  static const String mapBoxRoutingAPI = '/directions/v5/mapbox/cycling/';
  static const String mapBoxGeocodingAPI = '/geocoding/v5/mapbox.places/';
}
