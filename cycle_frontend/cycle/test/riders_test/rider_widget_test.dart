import 'package:cycle/components/slide_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing riderText widget is present',
      (WidgetTester tester) async {
    final riderText = find.byKey(const ValueKey('RiderText'));
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
    final riderValue = find.byKey(const ValueKey('RiderValue'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    expect(riderValue, findsOneWidget);
  });

  testWidgets('Testing riderText font colour', (WidgetTester tester) async {
    final riderText = find.byKey(const ValueKey('RiderText'));
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
    final riderValue = find.byKey(const ValueKey('RiderValue'));
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
    final riderText = find.byKey(const ValueKey('RiderText'));
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
    final riderValue = find.byKey(const ValueKey('RiderValue'));
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
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.pump();
    Icon icon = tester.firstWidget(riderIcon);
    expect(icon.color, Colors.red);
  });

  testWidgets('Testing the AlertDialog after tapping riders ',
      (WidgetTester tester) async {
    final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.tap(riderInkwell);
    await tester.pump();
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Testing the buttons load in AlertDialog ',
      (WidgetTester tester) async {
    final riderInkwell = find.byKey(const ValueKey('RiderInkwell'));
    await tester.pumpWidget(MaterialApp(
        home: SlideUpWidget(
      controller: ScrollController(),
      mapRefreshCallback: () {},
    )));
    await tester.tap(riderInkwell);
    await tester.pump();
    expect(find.text('OK'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
