import 'package:flutter_test/flutter_test.dart';
import 'package:cycle/components/slide_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cycle/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('RidersIntegration', () {
    testWidgets('Check initial default capacity of riders',
        (WidgetTester tester) async {
      app.main();
      final _slideUpWidgetState = SlideUpWidget(
              mapRefreshCallback: () {}, controller: ScrollController())
          .createState();
      int initialRiders = _slideUpWidgetState.numOfRiders;
      expect(initialRiders, 1);
    });

    testWidgets('Check updating rider capacity with values',
        (WidgetTester tester) async {
      final _slideUpWidgetState = SlideUpWidget(
              mapRefreshCallback: () {}, controller: ScrollController())
          .createState();
      dynamic initialRiders = _slideUpWidgetState.numOfRiders;
      expect(initialRiders, 1);
      final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      final textField = find.byKey(const ValueKey('RiderTextField'));
      TextField field = tester.firstWidget(textField);
      await tester.enterText(find.byKey(const ValueKey('RiderTextField')), '0');
      initialRiders = field.controller?.text;
      expect(int.parse(initialRiders), 0);
    });
  });
}
