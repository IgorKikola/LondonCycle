import 'dart:convert';

import 'package:cycle/components/searchbox.dart';
import 'package:cycle/pages/main_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cycle/components/slide_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cycle/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Stops Integration Tests', () {

    testWidgets('Check initial default capacity of riders',
        (WidgetTester tester) async {
      app.main();
      final _StopsState = Stops().createState();
      int numberOfStopObjects= _StopsState.stopObjects.length;
      expect(numberOfStopObjects, 0);
    });
    testWidgets('Test for creating a new Stop and then deleting it', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
      final addButton = find.byTooltip("Add Stop");
      await tester.pumpWidget(MaterialApp(home: Stops()));
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SearchBox));
      await tester.enterText(
          find.byKey(const ValueKey('Searchbar')), 'Test Landmark');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      final addStop = find.byIcon(Icons.add_circle);
      await tester.tap(addStop);
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.pumpWidget(MaterialApp(home: Stops()));
      final removeButton = find.byTooltip("Delete all stops and routes");
      await tester.tap(removeButton);
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byType(ListTile), findsNothing);
    });
  });
}
