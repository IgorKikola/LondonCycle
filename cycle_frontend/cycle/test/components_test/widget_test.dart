import 'package:cycle/components/slide_up_widget.dart';
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
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Bikepoints:'), findsOneWidget);
    expect(find.text('abcd'), findsNothing);
    expect(find.text('0'), findsNothing);
  });
}
