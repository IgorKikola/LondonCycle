import 'package:cycle/components/signup_form_components/first_name_field.dart';
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
        children: const <Widget>[
          FirstNameField(),
        ],
      ),
    );
  }
}
