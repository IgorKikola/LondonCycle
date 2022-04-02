import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:cycle/models/stop.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stops Unit Tests', () {
    test('Check if stops object list is empty', () {
      final _stopState = const Stops().createState();
      expect(_stopState.stopObjects.length, 0);
    });

    test('Testing if stops list has a stop object after creation', () {
      final _stopState = const Stops().createState();
      Stop stop = Stop(0, 'Test Landmark', 51.5007, 0.1246);
      _stopState.stopObjects.add(stop);
      expect(_stopState.stopObjects.length, 1);
      stop = _stopState.stopObjects.last;
      expect(stop.runtimeType, Stop);
    });

    test('Testing stops list to see if Stop object is removed', () {
      final _stopState = const Stops().createState();
      Stop stop = Stop(0, 'Test Landmark', 51.5007, 0.1246);
      _stopState.stopObjects.add(stop);
      expect(_stopState.stopObjects.length, 1);
      stop = _stopState.stopObjects.last;
      expect(stop.runtimeType, Stop);
      _stopState.stopObjects.remove(stop);
      expect(_stopState.stopObjects.length, 0);
    });

    test('Testing Stop Model', () {
      Stop stop = Stop(0, 'Test Landmark', 51.5007, 0.1246);
      expect(stop.id, 0);
      expect(stop.name, 'Test Landmark');
      expect(stop.lat, 51.5007);
      expect(stop.lon, 0.1246);
    });
  });
}
