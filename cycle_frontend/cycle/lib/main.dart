import 'package:cycle/pages/edit_profile.dart';
import 'package:cycle/pages/forgot_password_page.dart';
import 'package:cycle/pages/login_page.dart';
import 'package:cycle/pages/privacy_policy_page.dart';
import 'package:cycle/pages/signup_page.dart';
import 'package:cycle/pages/terms_of_use_page.dart';
import 'package:cycle/shared_service.dart';
import 'package:flutter/material.dart';
import 'pages/main_page.dart';

// Default page for users that are not logged in.
String _defaultPageId = LoginPage.id;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Checks cache if user's credentials are still saved so that user does not need
  // to login every time the app is opened.
  bool _isLoggedIn = await SharedService.isLoggedIn();
  if (_isLoggedIn) {
    _defaultPageId = MainPage.id;
  }
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
      initialRoute: _defaultPageId,
      routes: {
        SignupPage.id: (context) => SignupPage(),
        TermsOfUsePage.id: (context) => TermsOfUsePage(),
        PrivacyPolicyPage.id: (context) => PrivacyPolicyPage(),
        LoginPage.id: (context) => LoginPage(),
        MainPage.id: (context) => MainPage(),
        EditProfilePage.id: (context) => EditProfilePage(),
        ForgotPasswordPage.id: (context) => ForgotPasswordPage(),
      },
    );
  }
}
