import 'package:cycle/components/signup_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'signup_page';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-up form'),
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            Expanded(
              child: Text(
                'Sign-up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
