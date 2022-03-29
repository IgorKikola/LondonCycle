import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:cycle/models/stop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stop', () {
    test('Check if stops object list is empty', () {
      final _StopState = Stops().createState();
      expect(_StopState.stopObjects.length, 0);
    });

    test('Testing if stops list has a stop object after creation', () {
      final _StopState = Stops().createState();
      Stop stop = Stop(0, 'Test Landmark', 51.5007, 0.1246);
      _StopState.stopObjects.add(stop);
      expect(_StopState.stopObjects.length, 1);
      stop = _StopState.stopObjects.first;
      expect(stop.runtimeType, Stop);
    });

    test('Testing stops list to see if Stop object is removed', () {
      final _StopState = Stops().createState();
      Stop stop = Stop(0, 'Test Landmark', 51.5007, 0.1246);
      _StopState.stopObjects.add(stop);
      expect(_StopState.stopObjects.length, 1);
      stop = _StopState.stopObjects.first;
      expect(stop.runtimeType, Stop);
      _StopState.stopObjects.remove(stop);
      expect(_StopState.stopObjects.length, 0);
    });
  });
}
