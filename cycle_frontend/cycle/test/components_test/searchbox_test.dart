import 'package:cycle/components/slide_up_widget.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/finishing_location_search_bar.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/starting_location_search_bar.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("test destination widget loads correctly",
      (WidgetTester tester) async {
    final destIcon = find.byIcon(Icons.location_on_outlined);
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child:
                FinishingLocationSearchBar(myRoute: MyRouteProvider.myRoute))));
    await tester.pump();
    expect(destIcon, findsOneWidget);
  });

  testWidgets("test starting location widget loads correctly",
      (WidgetTester tester) async {
    final locIcon = find.byIcon(Icons.my_location_rounded);
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child:
                StartingLocationSearchBar(myRoute: MyRouteProvider.myRoute))));
    await tester.pump();
    expect(locIcon, findsOneWidget);
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

  testWidgets("test search button loads correctly",
      (WidgetTester tester) async {
    final searchButton = find.byIcon(Icons.search);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(searchButton, findsOneWidget);
  });

  testWidgets("test search button loads correctly",
      (WidgetTester tester) async {
    final navigateButton = find.byIcon(Icons.navigation);
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(navigateButton, findsOneWidget);
  });
}
