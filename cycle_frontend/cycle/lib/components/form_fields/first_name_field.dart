import 'package:cycle/services/string_validator.dart';
import 'package:cycle/services/validator_messages.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

/// First name field used in the sign-up form.
class FirstNameField extends StatefulWidget {
  final TextEditingController controller;
  final String initialText;
  final String label;
  final String hint;

  const FirstNameField(
      {required this.controller,
      required this.initialText,
      required this.label,
      required this.hint});

  @override
  FirstNameFieldState createState() {
    return FirstNameFieldState();
  }
}

class FirstNameFieldState extends State<FirstNameField> {
  final _validator = StringValidator();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialText == '' ? null : widget.initialText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        ValidatorMessage message = _validator.isFirstName(value);
        if (message != ValidatorMessage.defaultMessage) {
          return _validator.getText(message);
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
