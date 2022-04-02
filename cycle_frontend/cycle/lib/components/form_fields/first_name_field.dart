import 'package:cycle/services/string_validator.dart';
import 'package:cycle/utilities/validator_messages.dart';
import 'package:flutter/material.dart';

import '../../utilities/user_related_design_constants.dart';

/// First name field used in the sign-up form.
class FirstNameField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const FirstNameField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hint})
      : super(key: key);

  @override
  FirstNameFieldState createState() {
    return FirstNameFieldState();
  }
}

class FirstNameFieldState extends State<FirstNameField> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        ValidatorMessage message = StringValidator.isFirstName(value);
        if (message != ValidatorMessage.defaultMessage) {
          return StringValidator.getText(message);
        } else {
          return null;
        }
      },
      controller: widget.controller,
      decoration: kTextFieldDecoration.copyWith(
        labelText: widget.label,
        hintText: widget.hint,
        icon: const Icon(Icons.person),
      ),
    );
  }
}
