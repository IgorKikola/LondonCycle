import 'package:cycle/pages/main_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cycle/components/slide_up_widget.dart';
import 'package:cycle/services/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:cycle/services/marker_location.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';

void main() {
  test('Simple unit test.', () {
    int actualValue = 1;
    expect(actualValue, 1);
  });

  group('RidersUnit', () {
    testWidgets(
        'Testing the OK button functionality including redirect to SlideUpWidget ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(ValueKey('RiderTextField')), '3');
      final OkButton = find.text('OK');
      await tester.tap(OkButton);
      await tester.pump();
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('Testing the OK button functionality for 0 additional riders ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(ValueKey('RiderTextField')), '0');
      final OkButton = find.text('OK');
      await tester.tap(OkButton);
      await tester.pump();
      final ridersInputValue = find.text('1');
      expect(ridersInputValue, findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
        'Testing the OK button functionality for 1-5 additional riders ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(ValueKey('RiderTextField')), '4');
      final OkButton = find.text('OK');
      await tester.tap(OkButton);
      await tester.pump();
      final ridersInputValue = find.text('4');
      expect(ridersInputValue, findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
        'Testing the OK button functionality for more than 5 additional riders ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(ValueKey('RiderTextField')), '100');
      final OkButton = find.text('OK');
      await tester.tap(OkButton);
      await tester.pump();
      final ridersInputValue = find.text('5');
      expect(ridersInputValue, findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
        'Testing the Cancel button only redirects to the SlideUpWidget ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(ValueKey('RiderTextField')), '4');
      final cancelButton = find.text('Cancel');
      await tester.tap(cancelButton);
      await tester.pump();
      final ridersInputValue = find.text('4');
      final ridersDefaultValue = find.text('1');
      expect(ridersInputValue, findsNothing);
      expect(ridersDefaultValue, findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
