import 'package:cycle/models/named_lat_lng.dart';
import 'package:cycle/services/marker_location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Simple unit test.', () {
    int actualValue = 1;
    expect(actualValue, 1);
  });

  test('Marker start location is initialised correctly', () {
    MarkerLocation searchMarker = MarkerLocation();
    NamedLatLng start =
        NamedLatLng(latitude: 51.50, longitude: 0.12, name: 'starting marker');
    searchMarker.setStartingLocation(start);
    expect(searchMarker.getStartingLocation(), start);
  });

  test('Marker destination is initialised correctly', () {
    MarkerLocation searchMarker = MarkerLocation();
    NamedLatLng destination = NamedLatLng(
        latitude: 51.50, longitude: 0.12, name: 'destination marker');
    searchMarker.setDestination(destination);
    expect(searchMarker.getDestination(), destination);
  });
}
