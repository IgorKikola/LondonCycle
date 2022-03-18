import 'package:cycle/constants.dart';
import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatefulWidget {
  static const String id = 'starting_page';

  const StartingPage({Key? key}) : super(key: key);

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Cycles',
                style: TextStyle(fontSize: 80.0),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, SignupPage.id),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("Signup"),
                ),
                style: kSubmitButtonStyle,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, LoginPage.id),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("Login"),
                ),
                style: kSubmitButtonStyle,
              )
            ],
          ),
        )),
      ),
    );
  }
}
