import 'dart:convert';
import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:cycle/components/searchbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Test text on scaffold appbar', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    await tester.pumpWidget(MaterialApp(home: const Stops()));
    await tester.pump();
    expect(find.text('Stops'), findsOneWidget);
  });

  testWidgets('Test location of add stop floatingActionButton',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(const MaterialApp(home: Stops()));
    await tester.pump();
    expect(addButton, findsOneWidget);
  });

  testWidgets('Test location of remove stop floatingActionButton',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final removeButton = find.byTooltip("Delete all stops and routes");
    await tester.pumpWidget(MaterialApp(home: const Stops()));
    await tester.pump();
    expect(removeButton, findsOneWidget);
  });

  testWidgets('Test for AlertDialog to appear', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: const Stops()));
    await tester.tap(addButton);
    await tester.pump();
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Test for ElevatedButton Icon in AlertDialog',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
  });

  testWidgets('Test for ElevatedButton in AlertDialog',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Test for AlertDialog header text', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    expect(find.text('Add a stop'), findsOneWidget);
  });

  testWidgets('Test for Searchbox component in AlertDialog',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    expect(find.byType(SearchBox), findsOneWidget);
  });

  testWidgets(
      'Test for no activity when ElevatedButton is pressed with invalid input',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    final addStop = find.byIcon(Icons.add_circle);
    await tester.tap(addStop);
    await tester.pump();
    expect(find.byType(SearchBox), findsOneWidget);
    expect(find.text('Add a stop'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
  });

  testWidgets('Test for no activity after pressing enter key on keyboard',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(find.byType(SearchBox));
    await tester.testTextInput.receiveAction(TextInputAction.done);
    expect(find.byType(SearchBox), findsOneWidget);
    expect(find.text('Add a stop'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byIcon(Icons.add_circle), findsOneWidget);
  });

  testWidgets('Test for valid input in Searchbar', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(find.byType(SearchBox));
    await tester.enterText(find.byKey(const ValueKey('Searchbar')), 'Big Ben');
    await tester.pump();
    expect(find.byType(SearchBox), findsOneWidget);
    expect(find.text('Add a stop'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Big Ben'), findsOneWidget);
  });

  testWidgets('Test for new Stop text', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(find.byType(SearchBox));
    await tester.enterText(
        find.byKey(const ValueKey('Searchbar')), 'Test Landmark');
    await tester.pump();
    final addStop = find.byIcon(Icons.add_circle);
    await tester.tap(addStop);
    await tester.pump(Duration(seconds: 2));
    expect(find.text('Test Landmark'), findsOneWidget);
  });

  testWidgets('Test for new Stop ListTile and disappearance of AlertDialog on creation of new Stop', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(find.byType(SearchBox));
    await tester.enterText(
        find.byKey(const ValueKey('Searchbar')), 'Test Landmark');
    await tester.pump();
    final addStop = find.byIcon(Icons.add_circle);
    await tester.tap(addStop);
    await tester.pump(Duration(seconds: 2));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byType(SearchBox), findsNothing);
    expect(find.text('Add a stop'), findsNothing);
    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('Test for Stop ListTile styling', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(find.byType(SearchBox));
    await tester.enterText(
        find.byKey(const ValueKey('Searchbar')), 'Test Landmark');
    await tester.pump();
    final addStop = find.byIcon(Icons.add_circle);
    await tester.tap(addStop);
    await tester.pump(Duration(seconds: 2));
    Icon icon = tester.firstWidget(find.byIcon(Icons.delete));
    expect(find.byType(ListTile), findsOneWidget);
    expect(icon.color, Colors.red);
  });

  testWidgets('Test for Stop ListTile delete button', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(find.byType(SearchBox));
    await tester.enterText(
        find.byKey(const ValueKey('Searchbar')), 'Test Landmark');
    await tester.pump();
    final addStop = find.byIcon(Icons.add_circle);
    await tester.tap(addStop);
    await tester.pump(Duration(seconds: 2));
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });

  testWidgets('Test for Stop ListTile after reloading Stops page', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'stop': jsonEncode([])});
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.tap(addButton);
    await tester.pump();
    await tester.tap(find.byType(SearchBox));
    await tester.enterText(
        find.byKey(const ValueKey('Searchbar')), 'Test Landmark');
    await tester.pump();
    final addStop = find.byIcon(Icons.add_circle);
    await tester.tap(addStop);
    await tester.pump(Duration(seconds: 2));
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.pump();
    expect(find.text('Test Landmark'), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });
}
