// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cycle/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //tests for the menu
  testWidgets('test that menu loads correctly', (WidgetTester tester) async {
    final profileButton = find.text('My Profile');
    final mapButton = find.text('Map');
    await tester.pumpWidget(const MaterialApp(home: Menu()));
    await tester.pump();
    expect(profileButton, findsOneWidget);
    expect(mapButton, findsOneWidget);
  });

  testWidgets('test that menu icons load correctly',
      (WidgetTester tester) async {
    final profileButton = find.byIcon(Icons.contacts);
    final mapButton = find.byIcon(Icons.map);
    await tester.pumpWidget(const MaterialApp(home: Menu()));
    await tester.pump();
    expect(profileButton, findsOneWidget);
    expect(mapButton, findsOneWidget);
  });
}
