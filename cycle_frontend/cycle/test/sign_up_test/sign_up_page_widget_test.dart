import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';

void main() {
  testWidgets('Test for Sign-up text on scaffold appbar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupPage()));
    await tester.pump();
    expect(find.text('Sign-up'), findsOneWidget);
  });



  testWidgets('Test for all text on SignupPage and font', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupPage()));
    await tester.pump();
    Text font = tester.firstWidget(find.text('Create your account'));
    expect(find.text('Create your account'), findsOneWidget);
    expect(find.text('It\'s free and hardly takes more than a minute'), findsOneWidget);
    expect(find.text("Already have an account? Sign in", findRichText: true), findsOneWidget);
    expect(font.style?.fontFamily, 'Lobster');
  });

  testWidgets('Test for Divider widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupPage()));
    await tester.pump();
    expect(find.byType(Divider), findsNWidgets(2));
  });

}
