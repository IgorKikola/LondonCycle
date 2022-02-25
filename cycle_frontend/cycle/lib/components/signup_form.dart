import 'package:cycle/components/signup_form_components/email_field.dart';
import 'package:cycle/components/signup_form_components/first_name_field.dart';
import 'package:cycle/components/signup_form_components/last_name_field.dart';
import 'package:cycle/components/signup_form_components/password_field.dart';
import 'package:cycle/components/signup_form_components/password_repeat_field.dart';
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
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const FirstNameField(),
          const LastNameField(),
          const EmailField(),
          const PasswordField(),
          const PasswordRepeatField(),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // SAVE TO A DATABASE
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
