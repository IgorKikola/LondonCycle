import 'package:flutter/material.dart';

/// Password repeat field used in the sign-up form.
class PasswordRepeatField extends StatefulWidget {
  const PasswordRepeatField({Key? key}) : super(key: key);

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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
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
