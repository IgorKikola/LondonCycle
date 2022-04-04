// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cycle/components//slide_up_widget.dart';
/*import 'package:cycle/pages/favorites.dart';
import 'package:cycle/pages/menu.dart';
import 'package:cycle/pages/settings.dart';
import 'package:cycle/pages/trip_history.dart';*/
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
}
