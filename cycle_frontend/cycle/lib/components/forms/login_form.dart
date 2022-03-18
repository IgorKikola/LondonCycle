import 'package:another_flushbar/flushbar.dart';
import 'package:cycle/services/api_service.dart';
import 'package:cycle/components/form_button.dart';
import 'package:cycle/constants.dart';
import 'package:cycle/models/login_request_model.dart';
import 'package:cycle/pages/signup_login_pages/forgot_password_page.dart';
import 'package:cycle/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  bool hidePassword = true;

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
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
                    obscureText: hidePassword,
                    controller: passwordController,
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // "I forgot my password" section
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Align(
                alignment: Alignment.topRight,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "I forgot my password",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, ForgotPasswordPage.id);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Login button section
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: FormButton(
                text: 'Login',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If email and password fields are valid (not empty in this case)
                    // then save the form and show the progress hud.
                    _formKey.currentState?.save();
                    // Create a login request model which will be sent to the API.
                    LoginRequestModel model = LoginRequestModel(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    // Try to log in the user and if the response is not null (login was
                    // successful) open the main page of the application (save user details in cache).
                    APIService.login(model).then((response) {
                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, MainPage.id, (route) => false);
                      } else {
                        // If login was unsuccessful, show a bar for the user at the bottom of the screen.
                        Flushbar(
                          icon: const Icon(Icons.warning_rounded),
                          title: 'Credentials are invalid.',
                          message:
                              'Check if your email and password are correct.',
                          duration: const Duration(seconds: 5),
                          flushbarStyle: FlushbarStyle.GROUNDED,
                        ).show(context);
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
