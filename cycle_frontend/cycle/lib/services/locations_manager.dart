import 'package:cycle/services/network_helper.dart';
import '../constants.dart';

/// This class is responsible for returning a list of locations based on the provided coordinates.
class LocationsManager {
  var url = "http://api.opentripmap.com/0.1/en/places/bbox?";

  LocationsManager();

  Future getAttractionsAroundLocation(double latitude, double longitude) async {
    url +=
        "lon_min=${longitude - 0.01}&lat_min=${latitude - 0.01}&lon_max=${longitude + 0.01}&lat_max=${latitude + 0.01}"
        "&kinds=interesting_places&format=geojson&apikey=$kOpenTripMapAPIKey";

    final networkHelper = NetworkHelper(url);
    dynamic featureCollection = await networkHelper.getData();
    return featureCollection['features'];
  }
}
