import 'package:cycle/constants.dart';
import 'package:cycle/services/validator_messages.dart';
import 'package:flutter/material.dart';

import '../../services/string_validator.dart';

/// Password field used in the sign-up form.
class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField(this.controller, {Key? key}) : super(key: key);

  @override
  PasswordFieldState createState() {
    return PasswordFieldState();
  }
}

class PasswordFieldState extends State<PasswordField> {
  final _validator = StringValidator();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Password must have at least 8 characters including 1 number, 1 "
          "letter and 1 special character [@\$!%*#?&]",
      decoration: kFormFieldTooltipDecoration,
      textStyle: kFormFieldTooltipTextStyle,
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        obscureText: true,
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          ValidatorMessage message = _validator.isValidPassword(value);
          if (message != ValidatorMessage.defaultMessage) {
            return _validator.getText(message);
          } else {
            return null;
          }
        },
        decoration: kTextFieldDecoration.copyWith(
          icon: const Icon(Icons.lock),
          labelText: 'Password',
          hintText: 'Enter your password',
        ),
      ),
    );
  }
}