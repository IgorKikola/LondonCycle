import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../constants.dart';

/// Email field used in the sign-up form.
class EmailField extends StatefulWidget {
  final TextEditingController controller;

  const EmailField(this.controller, {Key? key}) : super(key: key);

  @override
  EmailFieldState createState() {
    return EmailFieldState();
  }
}

class EmailFieldState extends State<EmailField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!isEmail(value)) {
          return "Your provided email is invalid.";
        } else {
          return null;
        }
      },
      controller: widget.controller,
      decoration: kTextFieldDecoration.copyWith(
        icon: const Icon(Icons.mail),
        labelText: 'Email',
        hintText: 'Enter your email address',
      ),
    );
  }
}
