import 'package:cycle/constants.dart';
import 'package:flutter/material.dart';

/// Form for a login.
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  // Global key that uniquely identifies the LoginForm widget.
  final _formKey = GlobalKey<FormState>();

  // Controllers that keep track of the user's input.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Wrap(
                runSpacing: 20.0,
                children: <Widget>[
                  // EMAIL FIELD
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                    ),
                  ),
                  // PASSWORD FIELD
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                style: kSubmitButtonStyle,
                onPressed: () async {},
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text('Login', style: kSubmitButtonTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
