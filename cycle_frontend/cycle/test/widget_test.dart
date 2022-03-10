// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cycle/pages/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  //tests for the sliding panel on the home page
  /*testWidgets('test the sliding panel exists and drags as intended',
      (WidgetTester tester) async {
    //test code

    final slideUpPanel = find.byKey(ValueKey("slideUpPanel"));
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.drag(slideUpPanel, Offset(0, 235));
    await tester.pump();
    expect(find.byKey(ValueKey("slideUpPanel")), findsOneWidget);
  });*/

  //tests for landmarks
  testWidgets("test that the grey stars become yellow when tapped",
      (WidgetTester tester) async {
    //finders for the landmarks
    final londoneyeIcon = find.byKey(ValueKey("londonEyeIcon"));
    final bigbenIcon = find.byKey(ValueKey("bigBenIcon"));
    final theshardIcon = find.byKey(ValueKey("theShardIcon"));
    final towerbridgeIcon = find.byKey(ValueKey("towerBridgeIcon"));

    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.tap(londoneyeIcon);
    await tester.tap(bigbenIcon);
    await tester.tap(theshardIcon);
    await tester.tap(towerbridgeIcon);
    await tester.pump();
    expect((tester.widget(londoneyeIcon) as Icon).color, Colors.yellow);
    expect((tester.widget(bigbenIcon) as Icon).color, Colors.yellow);
    expect((tester.widget(theshardIcon) as Icon).color, Colors.yellow);
    expect((tester.widget(towerbridgeIcon) as Icon).color, Colors.yellow);
  });

  testWidgets("test that the grey stars become yellow when tapped",
      (WidgetTester tester) async {
    //finders for the landmarks
    final londoneyeIcon = find.byKey(ValueKey("londonEyeIcon"));
    final bigbenIcon = find.byKey(ValueKey("bigBenIcon"));
    final theshardIcon = find.byKey(ValueKey("theShardIcon"));
    final towerbridgeIcon = find.byKey(ValueKey("towerBridgeIcon"));

    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect((tester.widget(londoneyeIcon) as Icon).icon, Icons.star);
    expect((tester.widget(bigbenIcon) as Icon).icon, Icons.star);
    expect((tester.widget(theshardIcon) as Icon).icon, Icons.star);
    expect((tester.widget(towerbridgeIcon) as Icon).icon, Icons.star);
  });

  //test widgets load correctly
  testWidgets("test add stops widget loads correctly",
      (WidgetTester tester) async {
    final stopText = find.byKey(ValueKey('stoptext'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(stopText, findsOneWidget);
  });

  testWidgets("test destination widget loads correctly",
      (WidgetTester tester) async {
    final destText = find.byKey(ValueKey('destinationText'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(destText, findsOneWidget);
  });

  testWidgets("test add stops widget loads correctly",
      (WidgetTester tester) async {
    final locText = find.byKey(ValueKey('locationText'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(locText, findsOneWidget);
  });

  //test the FontFamilys
  testWidgets('test add stops FontFamily package', (WidgetTester tester) async {
    final stopText = find.byKey(ValueKey('stoptext'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(stopText);
    expect(text.style?.fontFamily, GoogleFonts.lato().fontFamily);
  });

  testWidgets('test destination FontFamily package',
      (WidgetTester tester) async {
    final destText = find.byKey(ValueKey('destinationText'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(destText);
    expect(text.style?.fontFamily, GoogleFonts.lato().fontFamily);
  });

  testWidgets('test current location FontFamily package',
      (WidgetTester tester) async {
    final locText = find.byKey(ValueKey('locationText'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(locText);
    expect(text.style?.fontFamily, GoogleFonts.lato().fontFamily);
  });

  //test the font colours
  testWidgets('Testing "Add stops" font colour', (WidgetTester tester) async {
    final stopText = find.byKey(ValueKey('stoptext'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(stopText);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Testing "Destination" font colour', (WidgetTester tester) async {
    final destText = find.byKey(ValueKey('destinationText'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(destText);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Testing "Current Location" font colour',
      (WidgetTester tester) async {
    final locText = find.byKey(ValueKey('locationText'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text = tester.firstWidget(locText);
    expect(text.style?.color, Colors.white);
  });

  //test the colours of the icons
  testWidgets('test that the stops icon is red', (WidgetTester tester) async {
    final stopsIcon = find.byKey(ValueKey('stopIcon'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Icon icon = tester.firstWidget(stopsIcon);
    expect(icon.color, Colors.red);
  });

  testWidgets('test that the destinations icon is red',
      (WidgetTester tester) async {
    final destIcon = find.byKey(ValueKey('destinationIcon'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Icon icon = tester.firstWidget(destIcon);
    expect(icon.color, Colors.red);
  });

  testWidgets('test that the current locations icon is red',
      (WidgetTester tester) async {
    final locIcon = find.byKey(ValueKey('locationIcon'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Icon icon = tester.firstWidget(locIcon);
    expect(icon.color, Colors.red);
  });
}
