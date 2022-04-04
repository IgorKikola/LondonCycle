import 'package:flutter/material.dart';

import '../../utilities/user_related_design_constants.dart';

/// Password repeat field used in the sign-up form.
class PasswordRepeatField extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final String label;
  final String hint;

  const PasswordRepeatField(
      {Key? key,
      required this.passwordController,
      required this.repeatPasswordController,
      required this.label,
      required this.hint})
      : super(key: key);

  @override
  PasswordRepeatFieldState createState() {
    return PasswordRepeatFieldState();
  }
}

class PasswordRepeatFieldState extends State<PasswordRepeatField> {
  bool hidePassword = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: widget.repeatPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please repeat your password';
          }
          if (!(widget.repeatPasswordController.text ==
              widget.passwordController.text)) {
            return 'Passwords do not match';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        obscureText: hidePassword,
        decoration: kTextFieldDecoration.copyWith(
          icon: const Icon(Icons.spellcheck),
          labelText: widget.label,
          hintText: widget.hint,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ),
    );
  }
}
