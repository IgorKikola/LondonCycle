import 'package:cycle/models/stop.dart';
import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:cycle/components/searchbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

void main() {

  testWidgets('Test text on scaffold appbar',
          (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Stops()));
    expect(find.text('Stops'), findsOneWidget);
  });

  testWidgets('Test location of add stop floatingActionButton',
      (WidgetTester tester) async {
    final addButton = find.byTooltip("Add Stop");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.pump();
    expect(addButton, findsOneWidget);
  });

  testWidgets('Test location of remove stop floatingActionButton',
      (WidgetTester tester) async {
    final removeButton = find.byTooltip("Delete all stops and routes");
    await tester.pumpWidget(MaterialApp(home: Stops()));
    await tester.pump();
    expect(removeButton, findsOneWidget);
  });

  testWidgets('Test for AlertDialog to appear',
          (WidgetTester tester) async {
        final addButton = find.byTooltip("Add Stop");
        await tester.pumpWidget(MaterialApp(home: Stops()));
        await tester.tap(addButton);
        await tester.pump();
        expect(find.byType(AlertDialog), findsOneWidget);
      });

  testWidgets('Test for ElevatedButton Icon in AlertDialog',
          (WidgetTester tester) async {
        final addButton = find.byTooltip("Add Stop");
        await tester.pumpWidget(MaterialApp(home: Stops()));
        await tester.tap(addButton);
        await tester.pump();
        expect(find.byIcon(Icons.add_circle), findsOneWidget);
      });

  testWidgets('Test for ElevatedButton in AlertDialog',
          (WidgetTester tester) async {
        final addButton = find.byTooltip("Add Stop");
        await tester.pumpWidget(MaterialApp(home: Stops()));
        await tester.tap(addButton);
        await tester.pump();
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

  testWidgets('Test for AlertDialog header text',
          (WidgetTester tester) async {
        final addButton = find.byTooltip("Add Stop");
        await tester.pumpWidget(MaterialApp(home: Stops()));
        await tester.tap(addButton);
        await tester.pump();
        expect(find.text('Add a stop'), findsOneWidget);
      });

  testWidgets('Test for Searchbox component in AlertDialog',
          (WidgetTester tester) async {
        final addButton = find.byTooltip("Add Stop");
        await tester.pumpWidget(MaterialApp(home: Stops()));
        await tester.tap(addButton);
        await tester.pump();
        expect(find.byType(SearchBox), findsOneWidget);
      });

  testWidgets('Test for no activity when ElevatedButton is pressed with invalid input',
          (WidgetTester tester) async {
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

}

