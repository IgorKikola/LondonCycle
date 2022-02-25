import 'package:flutter/material.dart';
import 'package:cycle/services/string_validator.dart';
import 'package:cycle/services/validator_messages.dart';

/// First name field used in the sign-up form.
class LastNameField extends StatefulWidget {
  const LastNameField({Key? key}) : super(key: key);

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
        ValidatorMessage message = _validator.isLastName(value!);
        if (value.isEmpty) {
          return 'Please enter your surname';
        } else if (message != ValidatorMessage.defaultMessage) {
          return _validator.getText(message);
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        labelText: 'Last name',
        hintText: 'Enter your last name',
        //errorText: getErrorText(),
      ),
    );
  }
}
