import 'package:cycle/models/place.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('tests for place model', () {
    test('should have the proper id', () {
      Place place = Place("p1", "Dummy Place", 51.5073, -0.12755);
      expect("p1", place.id);
    });

    test('should have the proper name', () {
      Place place = Place("p1", "Dummy Place", 51.5073, -0.12755);
      expect("Dummy Place", place.name);
    });

    test('should have the proper lat', () {
      Place place = Place("p1", "Dummy Place", 51.5073, -0.12755);
      expect(51.5073, place.lat);
    });

    test('should have the proper lon', () {
      Place place = Place("p1", "Dummy Place", 51.5073, -0.12755);
      expect(-0.12755, place.lon);
    });
  });
}
