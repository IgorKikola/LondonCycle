import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/components/forms/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test for Email Field in Login', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginForm()));
    await tester.pump();
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Enter your email address'), findsOneWidget);
  });

  testWidgets('Test for Password Field in Login', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginForm()));
    await tester.pump();
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
    expect(find.text("I forgot my password", findRichText: true), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
  });

  testWidgets('Test for Login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginForm()));
    await tester.pump();
    Text font = tester.firstWidget(find.text('Login'));
    expect(find.byType(CustomBlueButton), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(font.style?.fontFamily, 'Lobster');
  });

}
