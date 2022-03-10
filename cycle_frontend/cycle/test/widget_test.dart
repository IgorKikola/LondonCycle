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

  testWidgets("test that the grey stars load correctly",
      (WidgetTester tester) async {
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

  testWidgets("test navigate button loads correctly",
      (WidgetTester tester) async {
    final navigateButton = find.byKey(ValueKey('navigateIcon'));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(navigateButton, findsOneWidget);
  });

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

  testWidgets("test landmark text fields load correctly",
      (WidgetTester tester) async {
    final londoneyeText = find.byKey(ValueKey("londonEyeText"));
    final bigbenText = find.byKey(ValueKey("bigBenText"));
    final theshardText = find.byKey(ValueKey("theShardText"));
    final towerbridgeText = find.byKey(ValueKey("towerBridgeText"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(londoneyeText, findsOneWidget);
    expect(bigbenText, findsOneWidget);
    expect(theshardText, findsOneWidget);
    expect(towerbridgeText, findsOneWidget);
  });

  testWidgets("test landmark icons load correctly",
      (WidgetTester tester) async {
    final londoneyeIcon = find.byKey(ValueKey("londonEyeIcon"));
    final bigbenIcon = find.byKey(ValueKey("bigBenIcon"));
    final theshardIcon = find.byKey(ValueKey("theShardIcon"));
    final towerbridgeIcon = find.byKey(ValueKey("towerBridgeIcon"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(londoneyeIcon, findsOneWidget);
    expect(bigbenIcon, findsOneWidget);
    expect(theshardIcon, findsOneWidget);
    expect(towerbridgeIcon, findsOneWidget);
  });

  testWidgets("test bike point name fields load correctly",
      (WidgetTester tester) async {
    final horseferryRd = find.byKey(ValueKey("horseferryName"));
    final westministerPier = find.byKey(ValueKey("westministerName"));
    final vauxhallBr = find.byKey(ValueKey("vauxhallName"));
    final milbankTwr = find.byKey(ValueKey("milbankName"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(horseferryRd, findsOneWidget);
    expect(westministerPier, findsOneWidget);
    expect(vauxhallBr, findsOneWidget);
    expect(milbankTwr, findsOneWidget);
  });

  testWidgets("test bike point distance fields load correctly",
      (WidgetTester tester) async {
    final horseferryDst = find.byKey(ValueKey("horseferryDistance"));
    final westministerDst = find.byKey(ValueKey("westministerDistance"));
    final vauxhallDst = find.byKey(ValueKey("vauxhallDistance"));
    final milbankDst = find.byKey(ValueKey("milbankDistance"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    expect(horseferryDst, findsOneWidget);
    expect(westministerDst, findsOneWidget);
    expect(vauxhallDst, findsOneWidget);
    expect(milbankDst, findsOneWidget);
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

  testWidgets("test landmark text fields font family package",
      (WidgetTester tester) async {
    final londoneyeText = find.byKey(ValueKey("londonEyeText"));
    final bigbenText = find.byKey(ValueKey("bigBenText"));
    final theshardText = find.byKey(ValueKey("theShardText"));
    final towerbridgeText = find.byKey(ValueKey("towerBridgeText"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text1 = tester.widget(londoneyeText);
    Text text2 = tester.widget(bigbenText);
    Text text3 = tester.widget(theshardText);
    Text text4 = tester.widget(towerbridgeText);
    expect(text1.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text2.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text3.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text4.style?.fontFamily, GoogleFonts.lato().fontFamily);
  });

  testWidgets("test bike point name fields font family package",
      (WidgetTester tester) async {
    final horseferryRd = find.byKey(ValueKey("horseferryName"));
    final westministerPier = find.byKey(ValueKey("westministerName"));
    final vauxhallBr = find.byKey(ValueKey("vauxhallName"));
    final milbankTwr = find.byKey(ValueKey("milbankName"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text1 = tester.widget(horseferryRd);
    Text text2 = tester.widget(westministerPier);
    Text text3 = tester.widget(vauxhallBr);
    Text text4 = tester.widget(milbankTwr);
    expect(text1.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text2.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text3.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text4.style?.fontFamily, GoogleFonts.lato().fontFamily);
  });

  testWidgets("test bike point distance fields font family package",
      (WidgetTester tester) async {
    final horseferryDst = find.byKey(ValueKey("horseferryDistance"));
    final westministerDst = find.byKey(ValueKey("westministerDistance"));
    final vauxhallDst = find.byKey(ValueKey("vauxhallDistance"));
    final milbankDst = find.byKey(ValueKey("milbankDistance"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text1 = tester.widget(horseferryDst);
    Text text2 = tester.widget(westministerDst);
    Text text3 = tester.widget(vauxhallDst);
    Text text4 = tester.widget(milbankDst);
    expect(text1.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text2.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text3.style?.fontFamily, GoogleFonts.lato().fontFamily);
    expect(text4.style?.fontFamily, GoogleFonts.lato().fontFamily);
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

  testWidgets("test landmark text fields font colour",
      (WidgetTester tester) async {
    final londoneyeText = find.byKey(ValueKey("londonEyeText"));
    final bigbenText = find.byKey(ValueKey("bigBenText"));
    final theshardText = find.byKey(ValueKey("theShardText"));
    final towerbridgeText = find.byKey(ValueKey("towerBridgeText"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text1 = tester.widget(londoneyeText);
    Text text2 = tester.widget(bigbenText);
    Text text3 = tester.widget(theshardText);
    Text text4 = tester.widget(towerbridgeText);
    expect(text1.style?.color, Colors.white);
    expect(text2.style?.color, Colors.white);
    expect(text3.style?.color, Colors.white);
    expect(text4.style?.color, Colors.white);
  });

  testWidgets("test bike point name fields font colour",
      (WidgetTester tester) async {
    final horseferryRd = find.byKey(ValueKey("horseferryName"));
    final westministerPier = find.byKey(ValueKey("westministerName"));
    final vauxhallBr = find.byKey(ValueKey("vauxhallName"));
    final milbankTwr = find.byKey(ValueKey("milbankName"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text1 = tester.widget(horseferryRd);
    Text text2 = tester.widget(westministerPier);
    Text text3 = tester.widget(vauxhallBr);
    Text text4 = tester.widget(milbankTwr);
    expect(text1.style?.color, Colors.white);
    expect(text2.style?.color, Colors.white);
    expect(text3.style?.color, Colors.white);
    expect(text4.style?.color, Colors.white);
  });

  testWidgets("test bike point distance fields font colour",
      (WidgetTester tester) async {
    final horseferryDst = find.byKey(ValueKey("horseferryDistance"));
    final westministerDst = find.byKey(ValueKey("westministerDistance"));
    final vauxhallDst = find.byKey(ValueKey("vauxhallDistance"));
    final milbankDst = find.byKey(ValueKey("milbankDistance"));
    await tester.pumpWidget(
        MaterialApp(home: SlideUpWidget(controller: ScrollController())));
    await tester.pump();
    Text text1 = tester.widget(horseferryDst);
    Text text2 = tester.widget(westministerDst);
    Text text3 = tester.widget(vauxhallDst);
    Text text4 = tester.widget(milbankDst);
    expect(text1.style?.color, Colors.white);
    expect(text2.style?.color, Colors.white);
    expect(text3.style?.color, Colors.white);
    expect(text4.style?.color, Colors.white);
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
