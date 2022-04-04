import 'package:cycle/components/form_fields/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../utilities/user_related_design_constants.dart';

/// Email field used in the sign-up form.
class EmailField extends BaseField {
  const EmailField(
      {Key? key, required controller, required label, required hint})
      : super(key: key, controller: controller, label: label, hint: hint);

  @override
  EmailFieldState createState() {
    return EmailFieldState();
  }
}

class EmailFieldState extends BaseFieldState {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!isEmail(value)) {
            return "Your provided email is invalid.";
          } else {
            return null;
          }
        },
        controller: widget.controller,
        decoration: kTextFieldDecoration.copyWith(
          icon: const Icon(Icons.mail),
          labelText: widget.label,
          hintText: widget.hint,
        ),
      ),
    );
  }
}
