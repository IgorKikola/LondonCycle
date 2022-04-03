import 'package:cycle/components/slide_up_widget.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Simple unit test.', () {
    int actualValue = 1;
    expect(actualValue, 1);
  });

  group('RidersUnit', () {
    testWidgets(
        'Testing the OK button functionality including redirect to SlideUpWidget ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(const ValueKey('RiderTextField')), '3');
      final okButton = find.text('OK');
      await tester.tap(okButton);
      await tester.pump();
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('Testing the OK button functionality for 0 additional riders ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(const ValueKey('RiderTextField')), '0');
      final okButton = find.text('OK');
      await tester.tap(okButton);
      await tester.pump();
      final ridersInputValue = find.text('1');
      expect(ridersInputValue, findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
        'Testing the OK button functionality for 1-5 additional riders ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(const ValueKey('RiderTextField')), '4');
      final okButton = find.text('OK');
      await tester.tap(okButton);
      await tester.pump();
      final ridersInputValue = find.text('4');
      expect(ridersInputValue, findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
        'Testing the OK button functionality for more than 5 additional riders ',
        (WidgetTester tester) async {
      final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(
          find.byKey(const ValueKey('RiderTextField')), '100');
      final okButton = find.text('OK');
      await tester.tap(okButton);
      await tester.pump();
      final ridersInputValue = find.text('5');
      expect(ridersInputValue, findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets(
        'Testing the Cancel button only redirects to the SlideUpWidget ',
        (WidgetTester tester) async {
      MyRouteProvider.myRoute.numOfRiders = 1; //reset the number of riders
      final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
      await tester.pumpWidget(MaterialApp(
          home: SlideUpWidget(
        controller: ScrollController(),
        mapRefreshCallback: () {},
      )));
      await tester.tap(riderInkwell);
      await tester.pump();
      await tester.enterText(find.byKey(const ValueKey('RiderTextField')), '4');
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
