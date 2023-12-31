import 'package:cycle/components/form_fields/base_form_field.dart';
import 'package:cycle/services/string_validator.dart';
import 'package:cycle/utilities/validator_messages.dart';
import 'package:flutter/material.dart';

import '../../utilities/user_related_design_constants.dart';

/// First name field used in the sign-up form.
class FirstNameField extends BaseField {
  const FirstNameField(
      {Key? key, required controller, required label, required hint})
      : super(key: key, controller: controller, label: label, hint: hint);

  @override
  FirstNameFieldState createState() {
    return FirstNameFieldState();
  }
}

class FirstNameFieldState extends BaseFieldState {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
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
      ),
    );
  }
}
