import 'package:another_flushbar/flushbar.dart';
import 'package:cycle/components/form_fields/checkbox_text.dart';
import 'package:cycle/components/form_fields/email_field.dart';
import 'package:cycle/components/form_fields/first_name_field.dart';
import 'package:cycle/components/form_fields/last_name_field.dart';
import 'package:cycle/components/form_fields/password_field.dart';
import 'package:cycle/components/form_fields/password_repeat_field.dart';
import 'package:cycle/models/signup_request_model.dart';
import 'package:cycle/pages/loading_screens/signup_loading_screen.dart';
import 'package:flutter/material.dart';

import '../custom_blue_button.dart';

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
                  FirstNameField(
                    controller: firstNameController,
                    label: 'First name',
                    hint: 'Enter your first name',
                  ),
                  LastNameField(
                    controller: lastNameController,
                    label: 'Last name',
                    hint: 'Enter your last name',
                  ),
                  EmailField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter your email address',
                  ),
                  PasswordField(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                  ),
                  PasswordRepeatField(
                    passwordController: passwordController,
                    repeatPasswordController: repeatPasswordController,
                    label: 'Repeat your password',
                    hint: 'Repeat your password',
                  ),
                  // Checkbox part of the form.
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
                          Flexible(
                            child: CheckboxText(
                                termsAndPolicyWereNotChecked:
                                    termsAndPolicyWereNotChecked),
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
            // Submit button part.
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: CustomBlueButton(
                text: 'Submit',
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If all the inputs are of a valid format, save the form and show the
                    // progress indicator to the user.
                    _formKey.currentState?.save();
                    // Create a signup request model which will be sent to the API.
                    SignupRequestModel model = SignupRequestModel(
                      email: emailController.text,
                      password: passwordController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                    );
                    // Try to create a new user using the provided details.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignupLoadingScreen(model: model);
                    }));
                  } else {
                    // If the program reaches this bit, it means that some of the user input was
                    // not of a valid format.
                    Flushbar(
                      icon: const Icon(Icons.warning_rounded),
                      title: 'Oops... Something went wrong.',
                      message: 'Check if all the fields are filled correctly.',
                      duration: const Duration(seconds: 5),
                      flushbarStyle: FlushbarStyle.GROUNDED,
                    ).show(context);
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
