import 'package:cycle/models/place.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('tests for docking station model', () {
    test('should have the proper id', () {
      Place place = Place("s1", "Station", 51.5073, -0.12755);
      expect("s1", place.id);
    });

    test('should have the proper name', () {
      Place place = Place("s1", "Station", 51.5073, -0.12755);
      expect("Station", place.name);
    });

    test('should have the proper lat', () {
      Place place = Place("s1", "Station", 51.5073, -0.12755);
      expect(51.5073, place.lat);
    });

    test('should have the proper lon', () {
      Place place = Place("s1", "Station", 51.5073, -0.12755);
      expect(-0.12755, place.lon);
    });
  });
}
