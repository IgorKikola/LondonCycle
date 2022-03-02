import 'package:cycle/components/signup_form_components/email_field.dart';
import 'package:cycle/components/signup_form_components/first_name_field.dart';
import 'package:cycle/components/signup_form_components/last_name_field.dart';
import 'package:cycle/components/signup_form_components/password_field.dart';
import 'package:cycle/components/signup_form_components/password_repeat_field.dart';
import 'package:cycle/constants.dart';
import 'package:cycle/pages/privacy_policy_page.dart';
import 'package:cycle/pages/terms_of_use_page.dart';
import 'package:cycle/services/register_user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Form for a sign-up.
class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  // Global key that uniquely identifies the SignupForm widget.
  final _formKey = GlobalKey<FormState>();

  // Controllers that keep track of the user's input.
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  bool termsAndPolicyAccepted = false;
  bool termsAndPolicyWereNotChecked = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
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
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Wrap(
                runSpacing: 20.0,
                children: <Widget>[
                  FirstNameField(firstNameController),
                  LastNameField(lastNameController),
                  EmailField(emailController),
                  PasswordField(passwordController),
                  PasswordRepeatField(
                      passwordController, repeatPasswordController),
                  FormField<bool>(
                    builder: (state) {
                      return Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: Colors.blueAccent,
                            value: termsAndPolicyAccepted,
                            onChanged: (value) {
                              setState(
                                () {
                                  termsAndPolicyAccepted = value!;
                                },
                              );
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "I accept the ",
                                  style: TextStyle(
                                    color: termsAndPolicyWereNotChecked
                                        ? Theme.of(context).errorColor
                                        : Colors.white,
                                    fontWeight: termsAndPolicyWereNotChecked
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: "Terms of Use ",
                                  style: TextStyle(
                                    color: termsAndPolicyWereNotChecked
                                        ? Theme.of(context).errorColor
                                        : Colors.blueAccent,
                                    fontWeight: termsAndPolicyWereNotChecked
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, TermsOfUsePage.id);
                                    },
                                ),
                                TextSpan(
                                  text: "& ",
                                  style: TextStyle(
                                    color: termsAndPolicyWereNotChecked
                                        ? Theme.of(context).errorColor
                                        : Colors.white,
                                    fontWeight: termsAndPolicyWereNotChecked
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: TextStyle(
                                    color: termsAndPolicyWereNotChecked
                                        ? Theme.of(context).errorColor
                                        : Colors.blueAccent,
                                    fontWeight: termsAndPolicyWereNotChecked
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, PrivacyPolicyPage.id);
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    validator: (value) {
                      if (!termsAndPolicyAccepted) {
                        setState(() {
                          termsAndPolicyWereNotChecked = true;
                        });
                        return 'In order to create an account, '
                            'you must accept our Terms of Use and Privacy Policy';
                      } else {
                        termsAndPolicyWereNotChecked = false;
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    //_formKey.currentState.save();
                    Map data = {
                      'firstName': firstNameController.text,
                      'lastName': lastNameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                    };
                    RegisterUser register = RegisterUser();
                    Map response = await register.registerUser(data);
                    if (response['statusCode'] == 200) {
                      // User created successfully.
                      // Redirect user to the main page.
                      // Navigator.pushNamed(context, screen);
                    } else {
                      // Display response['body'] received from the server containing
                      // the message of what went wrong.
                    }
                  }
                },
                style: kSubmitButtonStyle,
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  child: Text('Submit', style: kSubmitButtonTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
