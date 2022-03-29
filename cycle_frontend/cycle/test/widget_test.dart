// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cycle/pages/favorites.dart';
import 'package:cycle/pages/menu.dart';
import 'package:cycle/pages/settings.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/pages/trip_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /*testWidgets('Sanity checks for some widgets inside SlideUpWidget',
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
  });*/

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

  testWidgets("test navigate button loads correctly",
      (WidgetTester tester) async {
    final navigateButton = find.byIcon(Icons.search);
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

  //tests for the menu
  testWidgets('test that menu loads correctly', (WidgetTester tester) async {
    final profileButton = find.text('My Profile');
    final mapButton = find.text('Map');
    final favButton = find.text('Favorites');
    final tripHButton = find.text('Trip History');
    final settingsButton = find.text('Settings');
    final editProfileButton = find.text('Edit Profile');
    await tester.pumpWidget(MaterialApp(home: Menu()));
    await tester.pump();
    expect(profileButton, findsOneWidget);
    expect(mapButton, findsOneWidget);
    expect(favButton, findsOneWidget);
    expect(tripHButton, findsOneWidget);
    expect(settingsButton, findsOneWidget);
    expect(editProfileButton, findsOneWidget);
  });

  testWidgets('test that menu icons load correctly',
      (WidgetTester tester) async {
    final profileButton = find.byIcon(Icons.contacts);
    final mapButton = find.byIcon(Icons.map);
    final favButton = find.byIcon(Icons.favorite);
    final tripHButton = find.byIcon(Icons.history);
    final settingsButton = find.byIcon(Icons.settings);
    final editProfileButton = find.byIcon(Icons.settings);
    await tester.pumpWidget(MaterialApp(home: Menu()));
    await tester.pump();
    expect(profileButton, findsOneWidget);
    expect(mapButton, findsOneWidget);
    expect(favButton, findsOneWidget);
    expect(tripHButton, findsOneWidget);
    expect(settingsButton, findsWidgets);
    expect(editProfileButton, findsWidgets);
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
