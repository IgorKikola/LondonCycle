import 'package:cycle/pages/main_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/services/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:cycle/services/marker_location.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cycle/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('RidersIntegration', () {
    testWidgets('Check initial default capacity of riders',
        (WidgetTester tester) async {
      app.main();
      final _SlideUpWidgetState = SlideUpWidget(
              mapRefreshCallback: () {}, controller: ScrollController())
          .createState();
      int initialRiders = _SlideUpWidgetState.numOfRiders;
      expect(initialRiders, 1);
    });

    testWidgets('Check updating rider capacity with values',
        (WidgetTester tester) async {
      final _SlideUpWidgetState = SlideUpWidget(
              mapRefreshCallback: () {}, controller: ScrollController())
          .createState();
      dynamic initialRiders = _SlideUpWidgetState.numOfRiders;
      expect(initialRiders, 1);
      final riderInkwell = find.byKey(ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      final textField = find.byKey(ValueKey('RiderTextField'));
      TextField field = tester.firstWidget(textField);
      await tester.enterText(find.byKey(ValueKey('RiderTextField')), '0');
      initialRiders = field.controller?.text;
      expect(int.parse(initialRiders), 0);
    });
  });
}
