import 'package:cycle/components/signup_form.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static const String id = 'signup_page';

  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                  child: Text(
                    'Create your account',
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                ),
                SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
