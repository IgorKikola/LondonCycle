import 'package:cycle/services/string_validator.dart';
import 'package:cycle/services/validator_messages.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

/// First name field used in the sign-up form.
class FirstNameField extends StatefulWidget {
  final TextEditingController controller;

  const FirstNameField(this.controller, {Key? key}) : super(key: key);

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
        labelText: 'First name',
        hintText: 'Enter your first name',
        icon: const Icon(Icons.person),
      ),
    );
  }
}
