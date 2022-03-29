import 'package:cycle/pages/home_page.dart';
import 'package:cycle/pages/menu_pages/edit_user_profile_page.dart';
import 'package:cycle/pages/signup_login_pages/forgot_password_page.dart';
import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:cycle/pages/starting_page.dart';
import 'package:cycle/pages/terms_policy_pages/privacy_policy_page.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:cycle/pages/terms_policy_pages/terms_of_use_page.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cycle/components/slide_up_widget.dart';
import 'package:cycle/components/menu.dart';

// Default page for users that are not logged in.
String _defaultPageId = StartingPage.id;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Checks cache if user's credentials are still saved so that user does not need
  // to login every time the app is opened.
  bool _isLoggedIn = await UserDetailsHelper.isLoggedIn();
  if (_isLoggedIn) {
    _defaultPageId = HomePage.id;
  }
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
      initialRoute: _defaultPageId,
      routes: {
        SignupPage.id: (context) => SignupPage(),
        TermsOfUsePage.id: (context) => TermsOfUsePage(),
        PrivacyPolicyPage.id: (context) => PrivacyPolicyPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => MainPage(),
        HomePage.id: (context) => HomePage(),
        ForgotPasswordPage.id: (context) => ForgotPasswordPage(),
        StartingPage.id: (context) => StartingPage(),
      },
    );
  }
}
