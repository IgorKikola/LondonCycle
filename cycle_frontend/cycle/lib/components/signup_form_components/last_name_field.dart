import 'package:flutter/material.dart';
import 'package:cycle/services/string_validator.dart';
import 'package:cycle/services/validator_messages.dart';

import '../../constants.dart';

/// First name field used in the sign-up form.
class LastNameField extends StatefulWidget {
  final TextEditingController controller;

  const LastNameField(this.controller, {Key? key}) : super(key: key);

  @override
  LastNameFieldState createState() {
    return LastNameFieldState();
  }
}

class LastNameFieldState extends State<LastNameField> {
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
          return 'Please enter your surname';
        }
        ValidatorMessage message = _validator.isLastName(value);
        if (message != ValidatorMessage.defaultMessage) {
          return _validator.getText(message);
        } else {
          return null;
        }
      },
      controller: widget.controller,
      decoration: kTextFieldDecoration.copyWith(
        labelText: 'Last name',
        hintText: 'Enter your last name',
        //errorText: getErrorText(),
      ),
    );
  }
}
