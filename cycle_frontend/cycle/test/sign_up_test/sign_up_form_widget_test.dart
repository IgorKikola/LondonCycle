import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/components/form_fields/checkbox_text.dart';
import 'package:cycle/components/form_fields/email_field.dart';
import 'package:cycle/components/form_fields/first_name_field.dart';
import 'package:cycle/components/form_fields/last_name_field.dart';
import 'package:cycle/components/form_fields/password_field.dart';
import 'package:cycle/components/form_fields/password_repeat_field.dart';
import 'package:cycle/components/forms/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test for FirstName Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupForm()));
    await tester.pump();
    expect(find.byType(FirstNameField), findsOneWidget);
    expect(find.text('First name'), findsOneWidget);
    expect(find.text('Enter your first name'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsNWidgets(2));
  });
  testWidgets('Test for LastName Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupForm()));
    await tester.pump();
    expect(find.byType(LastNameField), findsOneWidget);
    expect(find.text('Last name'), findsOneWidget);
    expect(find.text('Enter your last name'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsNWidgets(2));
  });
  testWidgets('Test for Password Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupForm()));
    await tester.pump();
    expect(find.byType(PasswordField), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);
  });
  testWidgets('Test for PasswordRepeat Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupForm()));
    await tester.pump();
    expect(find.byType(PasswordRepeatField), findsOneWidget);
    expect(find.text('Repeat your password'), findsNWidgets(2));
  });
  testWidgets('Test for Email Field', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupForm()));
    await tester.pump();
    expect(find.byType(EmailField), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Enter your email address'), findsOneWidget);
  });
  testWidgets('Test for Checkbox', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupForm()));
    await tester.pump();
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byType(CheckboxText), findsOneWidget);
  });
  testWidgets('Test for Submit button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignupForm()));
    await tester.pump();
    expect(find.byType(CustomBlueButton), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });
}
