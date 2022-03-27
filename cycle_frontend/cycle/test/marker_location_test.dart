import 'package:flutter_test/flutter_test.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/services/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:cycle/services/marker_location.dart';
import 'package:latlong2/latlong.dart';

void main() {
  test('Simple unit test.', () {
    int actualValue = 1;
    expect(actualValue, 1);
  });

  test('Marker start location is initialised correctly', () {
    MarkerLocation searchMarker = MarkerLocation();
    Coordinate start = Coordinate(latitude: 51.50, longitude: 0.12);
    searchMarker.setStartingLocation(start);
    expect(searchMarker.getStartingLocation(), start);
  });

  test('Marker destination is initialised correctly', () {
    MarkerLocation searchMarker = MarkerLocation();
    Coordinate destination = Coordinate(latitude: 51.50, longitude: 0.12);
    searchMarker.setDestination(destination);
    expect(searchMarker.getDestination(), destination);
  });
}
