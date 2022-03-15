import 'package:cycle/pages/login_page.dart';
import 'package:cycle/pages/privacy_policy_page.dart';
import 'package:cycle/pages/signup_page.dart';
import 'package:cycle/pages/terms_of_use_page.dart';
import 'package:flutter/material.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: MainPage.id,
      routes: {
        SignupPage.id: (context) => const SignupPage(),
        TermsOfUsePage.id: (context) => const TermsOfUsePage(),
        PrivacyPolicyPage.id: (context) => const PrivacyPolicyPage(),
        LoginPage.id: (context) => const LoginPage(),
        MainPage.id: (context) => const MainPage(),
      },
    );
  }
}
