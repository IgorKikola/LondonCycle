import 'package:cycle/services/network_helper.dart';

import '../constants.dart';

class PlacesLocationManager {
  var url = "http://api.opentripmap.com/0.1/en/places/bbox?";

  PlacesLocationManager();

  Future getAttractionsAroundLocation(double latitude, double longitude) async {
    url =
        "lon_min=${longitude - 0.01}&lat_min=${latitude - 0.01}&lon_max=${longitude + 0.01}&lat_max=${latitude + 0.01}"
        "&kinds=interesting_places&format=geojson&apikey=$kOpenTripMapAPIKey";
    final networkHelper = NetworkHelper(url);

    return await networkHelper.getData();
  }
}
