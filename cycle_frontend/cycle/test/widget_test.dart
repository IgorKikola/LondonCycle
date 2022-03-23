// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cycle/pages/slide_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Sanity checks for some widgets inside SlideUpWidget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SlideUpWidget(
          controller: ScrollController(),
          mapRefreshCallback: () {},
        ),
      ),
    );
    await tester.pump();

    // Verify that some core widgets are displayed on the SlideUp widget.
    expect(find.text('Starting location'), findsOneWidget);
    expect(find.text('Destination'), findsOneWidget);
    expect(find.text('Stops'), findsOneWidget);
    expect(find.text('0'), findsOneWidget); //TODO: should really start with one
    expect(find.text('Land...'), findsOneWidget);
    expect(find.text('Bike...'), findsOneWidget);
    expect(find.text('abcd'), findsNothing);
    expect(find.text('1'), findsNothing); //TODO: as above
  });

  testWidgets('Testing riderText widget is present',
      (WidgetTester tester) async {
    final riderText = find.byKey(ValueKey('RiderText'));
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(riderText, findsOneWidget);
  });

  testWidgets('Testing riderValue widget is present',
      (WidgetTester tester) async {
    //final riderValue = find.text('0'); //TODO: should really start with one
    final riderValue = find.byKey(ValueKey('RiderValue'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(riderValue, findsOneWidget);
  });

  testWidgets('Testing riderText font colour', (WidgetTester tester) async {
    final riderText = find.byKey(ValueKey('RiderText'));
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(riderText);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Testing riderValue font colour', (WidgetTester tester) async {
    //final riderValue = find.text('0'); //TODO: should really start with one
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    final riderValue = find.byKey(ValueKey('RiderValue'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(riderValue);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Testing riderText FontFamily package',
      (WidgetTester tester) async {
    final riderText = find.byKey(ValueKey('RiderText'));
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(riderText);
    expect(text.style?.fontFamily, 'Lato');
  });

  testWidgets('Testing riderValue FontFamily package',
      (WidgetTester tester) async {
    //final riderValue = find.text('0'); //TODO: should really start with one
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    final riderValue = find.byKey(ValueKey('RiderValue'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(riderValue);
    expect(text.style?.fontFamily, 'Lato');
  });

  testWidgets('Testing the riderIcon is the correct design ',
      (WidgetTester tester) async {
    final riderIcon = find.byIcon(Icons.person_add);
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Icon icon = tester.firstWidget(riderIcon);
    expect(icon.icon, Icons.person_add);
  });

  testWidgets('Testing riderIcon colour ', (WidgetTester tester) async {
    final riderIcon = find.byIcon(Icons.person_add);
    //final riderContainer = find.byKey(ValueKey('RiderContainer'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Icon icon = tester.firstWidget(riderIcon);
    expect(icon.color, Colors.red);
  });
}
