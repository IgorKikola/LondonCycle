import 'package:cycle/pages/home_page.dart';
import 'package:cycle/pages/navigation_page.dart';
import 'package:cycle/pages/signup_login_pages/forgot_password_page.dart';
import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:cycle/pages/starting_page.dart';
import 'package:cycle/pages/terms_policy_pages/privacy_policy_page.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:cycle/pages/terms_policy_pages/terms_of_use_page.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/main_page.dart';

// Default page for users that are not logged in.
String defaultPageId = StartingPage.id;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Checks cache if user's credentials are still saved so that user does not need
  // to login every time the app is opened.
  bool _isLoggedIn = await UserDetailsHelper.isLoggedIn();
  if (_isLoggedIn) {
    defaultPageId = HomePage.id;
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cycle',
      theme: ThemeData.dark(),
      initialRoute: StartingPage.id,
      routes: {
        SignupPage.id: (context) => const SignupPage(),
        TermsOfUsePage.id: (context) => const TermsOfUsePage(),
        PrivacyPolicyPage.id: (context) => const PrivacyPolicyPage(),
        LoginPage.id: (context) => const LoginPage(),
        MainPage.id: (context) => const MainPage(),
        HomePage.id: (context) => const HomePage(),
        ForgotPasswordPage.id: (context) => const ForgotPasswordPage(),
        StartingPage.id: (context) => const StartingPage(),
        NavigationPage.id: (context) => const NavigationPage(),
      },
    );
  }
}
