import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import '../../utilities/user_related_design_constants.dart';

/// Email field used in the sign-up form.
class EmailField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const EmailField(
      {required this.controller, required this.label, required this.hint});

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
        labelText: widget.label,
        hintText: widget.hint,
      ),
    );
  }
}
