import 'package:cycle/pages/loading_screens/login_loading_screen.dart';
import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/utilities/user_related_design_constants.dart';
import 'package:cycle/models/login_request_model.dart';
import 'package:cycle/pages/signup_login_pages/forgot_password_page.dart';
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
                  Material(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                      ),
                    ),
                  ),
                  // PASSWORD FIELD
                  Material(
                    child: TextFormField(
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
              child: CustomBlueButton(
                text: 'Login',
                key: const Key('LoginButton'),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginLoadingScreen(model: model);
                    }));
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
