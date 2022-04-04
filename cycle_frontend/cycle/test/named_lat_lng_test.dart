import 'package:cycle/models/named_lat_lng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NamedLatLng object test.', () {
    NamedLatLng namedLatLng =
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start');

    double actualStartLat = namedLatLng.latitude;
    double actualStartLon = namedLatLng.longitude;
    String actualStartName = namedLatLng.name;

    expect(actualStartLat, 0.0);
    expect(actualStartLon, 1.0);
    expect(actualStartName, 'start');
  });

  test('NamedLatLng toString test.', () {
    NamedLatLng namedLatLng =
        NamedLatLng(latitude: 0.0, longitude: 1.0, name: 'start');

    String actualString = namedLatLng.toString();

    expect(actualString, 'lat: 0.0, long: 1.0, name: start');
  });
}
