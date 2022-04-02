import 'package:cycle/components/form_fields/base_form_field.dart';
import 'package:cycle/services/string_validator.dart';
import 'package:cycle/utilities/validator_messages.dart';
import 'package:flutter/material.dart';

import '../../utilities/user_related_design_constants.dart';

/// First name field used in the sign-up form.
class LastNameField extends BaseField {
  const LastNameField(
      {Key? key, required controller, required label, required hint})
      : super(key: key, controller: controller, label: label, hint: hint);
  @override
  LastNameFieldState createState() {
    return LastNameFieldState();
  }
}

class LastNameFieldState extends BaseFieldState {
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
        ValidatorMessage message = StringValidator.isLastName(value);
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
