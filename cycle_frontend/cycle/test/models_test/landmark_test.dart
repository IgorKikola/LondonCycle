import 'package:cycle/models/place.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('tests for landmark model', () {
    test('should have the proper id', () {
      Place place = Place("l1", "Landmark", 51.5073, -0.12755);
      expect("l1", place.id);
    });

    test('should have the proper name', () {
      Place place = Place("l1", "Landmark", 51.5073, -0.12755);
      expect("Landmark", place.name);
    });

    test('should have the proper lat', () {
      Place place = Place("l1", "Landmark", 51.5073, -0.12755);
      expect(51.5073, place.lat);
    });

    test('should have the proper lon', () {
      Place place = Place("l1", "Landmark", 51.5073, -0.12755);
      expect(-0.12755, place.lon);
    });
  });
}
