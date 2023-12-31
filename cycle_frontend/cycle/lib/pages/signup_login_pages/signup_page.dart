import 'package:cycle/components/forms/signup_form.dart';
import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:flutter/gestures.dart';
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
              children: <Widget>[
                const Padding(
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
                  child: Text('It\'s free and hardly takes more than a minute',
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                      )),
                ),
                const Divider(
                  height: 20,
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
                const SignupForm(),
                const Divider(
                  height: 20,
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Already have an account? ",
                        ),
                        TextSpan(
                          text: "Sign in",
                          style: const TextStyle(
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, LoginPage.id);
                            },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
