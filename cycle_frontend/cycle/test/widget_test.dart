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

  //---------------------------------------------------------------------

  testWidgets("test that the grey stars become yellow when tapped",
      (WidgetTester tester) async {
    //finders for the landmarks
    final landmarkStarIcon = find.byIcon(Icons.star);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.tap(landmarkStarIcon.first);
    await tester.tap(landmarkStarIcon.last);
    await tester.pump();
    expect(
        (tester.widget(landmarkStarIcon.first) as Icon).color, Colors.yellow);
    expect((tester.widget(landmarkStarIcon.last) as Icon).color, Colors.yellow);
  });

  testWidgets("test that the grey stars load correctly",
      (WidgetTester tester) async {
    final landmarkStarIcon = find.byIcon(Icons.star);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect((tester.widget(landmarkStarIcon.first) as Icon).icon, Icons.star);
    expect((tester.widget(landmarkStarIcon.last) as Icon).icon, Icons.star);
  });

  //test widgets load correctly

  testWidgets("test navigate button loads correctly",
      (WidgetTester tester) async {
    final navigateButton = find.byKey(ValueKey('navigateIcon'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(navigateButton, findsOneWidget);
  });

  testWidgets("test add stops widget loads correctly",
      (WidgetTester tester) async {
    final stopText = find.byKey(ValueKey('stoptext'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(stopText, findsOneWidget);
  });

  testWidgets("test destination widget loads correctly",
      (WidgetTester tester) async {
    final destIcon = find.byIcon(Icons.location_on_outlined);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(destIcon, findsOneWidget);
  });

  testWidgets("test starting location widget loads correctly",
      (WidgetTester tester) async {
    final locIcon = find.byIcon(Icons.my_location_rounded);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(locIcon, findsOneWidget);
  });

  testWidgets("test landmark text fields load correctly",
      (WidgetTester tester) async {
    final londoneyeText = find.byKey(ValueKey('londonEye'));
    final bigbenText = find.byKey(ValueKey('bigBen'));
    final theshardText = find.byKey(ValueKey('theShard'));
    final towerbridgeText = find.byKey(ValueKey('towerBridge'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(londoneyeText, findsOneWidget);
    expect(bigbenText, findsOneWidget);
    expect(theshardText, findsOneWidget);
    expect(towerbridgeText, findsOneWidget);
  });

  testWidgets("test bike point name fields load correctly",
      (WidgetTester tester) async {
    final horseferryRd = find.byKey(ValueKey("horseferryName"));
    final westministerPier = find.byKey(ValueKey("westministerName"));
    final vauxhallBr = find.byKey(ValueKey("vauxhallName"));
    final milbankTwr = find.byKey(ValueKey("milbankName"));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(horseferryRd, findsOneWidget);
    expect(westministerPier, findsOneWidget);
    expect(vauxhallBr, findsOneWidget);
    expect(milbankTwr, findsOneWidget);
  });

  /*
  This tests functionality which hasn't been fully implemented yet so it will be left commented out for the time being

  testWidgets("test bike point distance fields load correctly",
      (WidgetTester tester) async {
    final horseferryDst = find.byKey(ValueKey("horseferryDistance"));
    final westministerDst = find.byKey(ValueKey("westministerDistance"));
    final vauxhallDst = find.byKey(ValueKey("vauxhallDistance"));
    final milbankDst = find.byKey(ValueKey("milbankDistance"));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(horseferryDst, findsOneWidget);
    expect(westministerDst, findsOneWidget);
    expect(vauxhallDst, findsOneWidget);
    expect(milbankDst, findsOneWidget);
  });
*/

  //test the FontFamilys
  testWidgets('test add stops FontFamily package', (WidgetTester tester) async {
    final stopText = find.byKey(ValueKey('stoptext'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(stopText);
    expect(text.style?.fontFamily, 'Lato');
  });

  testWidgets('test destination FontFamily package',
      (WidgetTester tester) async {
    final destText = find.text('Destination');
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(destText);
    expect(text.style?.fontFamily, 'Lato');
  });

  testWidgets('test starting location FontFamily package',
      (WidgetTester tester) async {
    final locText = find.text('Starting location');
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(locText);
    expect(text.style?.fontFamily, 'Lato');
  });

  /*
  This one is a work in progress

  testWidgets("test landmark text fields font family package",
      (WidgetTester tester) async {
    final londoneyeText = find.byKey(ValueKey("londonEye"));
    final bigbenText = find.byKey(ValueKey("bigBen"));
    final theshardText = find.byKey(ValueKey("theShard"));
    final towerbridgeText = find.byKey(ValueKey("towerBridge"));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text1 = tester.widget(londoneyeText);
    Text text2 = tester.widget(bigbenText);
    Text text3 = tester.widget(theshardText);
    Text text4 = tester.widget(towerbridgeText);
    expect(text1.style?.fontFamily, 'Lato');
    expect(text2.style?.fontFamily, 'Lato');
    expect(text3.style?.fontFamily, 'Lato');
    expect(text4.style?.fontFamily, 'Lato');
  });*/

  /*
  This one is a work in progress
  testWidgets("test bike point name fields font family package",
      (WidgetTester tester) async {
    final horseferryRd = find.byKey(ValueKey("horseferryName"));
    final westministerPier = find.byKey(ValueKey("westministerName"));
    final vauxhallBr = find.byKey(ValueKey("vauxhallName"));
    final milbankTwr = find.byKey(ValueKey("milbankName"));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text1 = tester.widget(horseferryRd);
    Text text2 = tester.widget(westministerPier);
    Text text3 = tester.widget(vauxhallBr);
    Text text4 = tester.widget(milbankTwr);
    expect(text1.style?.fontFamily, 'Lato');
    expect(text2.style?.fontFamily, 'Lato');
    expect(text3.style?.fontFamily, 'Lato');
    expect(text4.style?.fontFamily, 'Lato');
  });*/

  /*
  Also a work in progress
  testWidgets("test bike point distance fields font family package",
      (WidgetTester tester) async {
    final horseferryDst = find.byKey(ValueKey("horseferryDistance"));
    final westministerDst = find.byKey(ValueKey("westministerDistance"));
    final vauxhallDst = find.byKey(ValueKey("vauxhallDistance"));
    final milbankDst = find.byKey(ValueKey("milbankDistance"));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text1 = tester.widget(horseferryDst);
    Text text2 = tester.widget(westministerDst);
    Text text3 = tester.widget(vauxhallDst);
    Text text4 = tester.widget(milbankDst);
    expect(text1.style?.fontFamily, 'Lato');
    expect(text2.style?.fontFamily, 'Lato');
    expect(text3.style?.fontFamily, 'Lato');
    expect(text4.style?.fontFamily, 'Lato');
  });*/

  //test the font colours
  testWidgets('Testing "Add stops" font colour', (WidgetTester tester) async {
    final stopText = find.byKey(ValueKey('stoptext'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(stopText);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Testing "Destination" font colour', (WidgetTester tester) async {
    final destText = find.text('Destination');
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(destText);
    expect(text.style?.color, Colors.white);
  });

  testWidgets('Testing "Starting Location" font colour',
      (WidgetTester tester) async {
    final locText = find.text('Starting location');
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text = tester.firstWidget(locText);
    expect(text.style?.color, Colors.white);
  });

  /*
  Work in progress
  
  testWidgets("test landmark text fields font colour",
      (WidgetTester tester) async {
    final londoneyeText = find.byKey(ValueKey("londonEyeText"));
    final bigbenText = find.byKey(ValueKey("bigBenText"));
    final theshardText = find.byKey(ValueKey("theShardText"));
    final towerbridgeText = find.byKey(ValueKey("towerBridgeText"));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
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
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
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
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Text text1 = tester.widget(horseferryDst);
    Text text2 = tester.widget(westministerDst);
    Text text3 = tester.widget(vauxhallDst);
    Text text4 = tester.widget(milbankDst);
    expect(text1.style?.color, Colors.white);
    expect(text2.style?.color, Colors.white);
    expect(text3.style?.color, Colors.white);
    expect(text4.style?.color, Colors.white);
  });*/

  //test the colours of the icons
  testWidgets('test that the stops icon is red', (WidgetTester tester) async {
    final stopsIcon = find.byIcon(Icons.add_location_alt);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Icon icon = tester.firstWidget(stopsIcon);
    expect(icon.color, Colors.red);
  });

  testWidgets('test that the destinations icon is red',
      (WidgetTester tester) async {
    final destIcon = find.byIcon(Icons.location_on_outlined);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Icon icon = tester.firstWidget(destIcon);
    expect(icon.color, Colors.red);
  });

  testWidgets('test that the starting locations icon is red',
      (WidgetTester tester) async {
    final locIcon = find.byIcon(Icons.my_location_rounded);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Icon icon = tester.firstWidget(locIcon);
    expect(icon.color, Colors.red);
  });
}
