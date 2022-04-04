// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cycle/components/menu.dart';
import 'package:cycle/pages/menu_pages/favorites.dart';
import 'package:cycle/pages/menu_pages/settings.dart';
import 'package:cycle/pages/menu_pages/trip_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //tests for the menu
  testWidgets('test that menu loads correctly', (WidgetTester tester) async {
    final profileButton = find.text('My Profile');
    final mapButton = find.text('Map');
    final favButton = find.text('Favorites');
    final tripHButton = find.text('Trip History');
    final settingsButton = find.text('Settings');
    await tester.pumpWidget(MaterialApp(home: Menu()));
    await tester.pump();
    expect(profileButton, findsOneWidget);
    expect(mapButton, findsOneWidget);
    expect(favButton, findsOneWidget);
    expect(tripHButton, findsOneWidget);
    expect(settingsButton, findsOneWidget);
  });

  testWidgets('test that menu icons load correctly',
      (WidgetTester tester) async {
    final profileButton = find.byIcon(Icons.contacts);
    final mapButton = find.byIcon(Icons.map);
    final favButton = find.byIcon(Icons.favorite);
    final tripHButton = find.byIcon(Icons.history);
    final settingsButton = find.byIcon(Icons.settings);
    await tester.pumpWidget(MaterialApp(home: Menu()));
    await tester.pump();
    expect(profileButton, findsOneWidget);
    expect(mapButton, findsOneWidget);
    expect(favButton, findsOneWidget);
    expect(tripHButton, findsOneWidget);
    expect(settingsButton, findsWidgets);
  });

  //tests for the favorites tab
  testWidgets('test that the favorites tab loads', (WidgetTester tester) async {
    final title = find.text('Favorites');
    await tester.pumpWidget(MaterialApp(home: Favorites()));
    await tester.pump();
    expect(title, findsOneWidget);
  });

  //tests for the trip history tab
  testWidgets('test that the trip history tab loads',
      (WidgetTester tester) async {
    final title = find.text('Trip History');
    await tester.pumpWidget(MaterialApp(home: TripHistory()));
    await tester.pump();
    expect(title, findsOneWidget);
  });

  //tests for the settings tab
  testWidgets('test that the settings tab loads', (WidgetTester tester) async {
    final title = find.text('Settings');
    await tester.pumpWidget(MaterialApp(home: Settings()));
    await tester.pump();
    expect(title, findsOneWidget);
  });
}
