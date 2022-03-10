// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cycle/pages/slide_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cycle/main.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  testWidgets('Testing riderText widget is present',
      (WidgetTester tester) async {
    final riderText = find.byKey(ValueKey('RiderText'));
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(riderText, findsOneWidget);
  });

  testWidgets('Testing riderValue widget is present',
      (WidgetTester tester) async {
    final riderValue = find.byKey(ValueKey('RiderValue'));
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(riderValue, findsOneWidget);
  });

  testWidgets('Testing riderText font colour', (WidgetTester tester) async {
    final riderText = find.byKey(ValueKey('RiderText'));
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(riderText);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Testing riderValue font colour', (WidgetTester tester) async {
    final riderValue = find.byKey(ValueKey('RiderValue'));
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(riderValue);
    expect(text.style?.color, Colors.white);
  });
}
