import 'package:flutter/material.dart';

import '../../services/string_validator.dart';

/// Password repeat field used in the sign-up form.
class PasswordRepeatField extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  const PasswordRepeatField(
      this.passwordController, this.repeatPasswordController,
      {Key? key})
      : super(key: key);

  @override
  PasswordRepeatFieldState createState() {
    return PasswordRepeatFieldState();
  }
}

class PasswordRepeatFieldState extends State<PasswordRepeatField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.repeatPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (!(widget.repeatPasswordController.text ==
            widget.passwordController.text)) {
          return 'Passwords do not match';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Repeat password',
        hintText: 'Repeat your password',
      ),
    );
  }
}
