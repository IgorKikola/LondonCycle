import 'package:cycle/components/signup_form_components/email_field.dart';
import 'package:cycle/components/signup_form_components/first_name_field.dart';
import 'package:cycle/components/signup_form_components/last_name_field.dart';
import 'package:cycle/components/signup_form_components/password_field.dart';
import 'package:cycle/components/signup_form_components/password_repeat_field.dart';
import 'package:cycle/constants.dart';
import 'package:cycle/services/register_user.dart';
import 'package:flutter/material.dart';

/// Form for a sign-up.
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  // Global key that uniquely identifies the SignUpForm widget.
  final _formKey = GlobalKey<FormState>();

  // Controllers that keep track of the user's input.
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: <Widget>[
                  FirstNameField(firstNameController),
                  LastNameField(lastNameController),
                  EmailField(emailController),
                  PasswordField(passwordController),
                  PasswordRepeatField(
                      passwordController, repeatPasswordController),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
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
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
