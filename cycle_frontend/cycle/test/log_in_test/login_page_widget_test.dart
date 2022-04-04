import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('Test for login text on scaffold appbar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pump();
    expect(find.byKey(ValueKey('LoginScaffold')), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(2));
  });

  testWidgets('Test for text on LoginPage and font', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pump();
    Text font = tester.firstWidget(find.text('Login to your account'));
    expect(find.text('Login to your account'), findsOneWidget);
    expect(font.style?.fontFamily, 'Lobster');
  });

  testWidgets('Test for Divider widget', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.pump();
    expect(find.byType(Divider), findsOneWidget);
  });

}
