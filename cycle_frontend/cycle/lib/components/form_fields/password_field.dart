import 'package:cycle/components/form_fields/base_form_field.dart';
import 'package:cycle/utilities/user_related_design_constants.dart';
import 'package:cycle/utilities/validator_messages.dart';
import 'package:flutter/material.dart';

import '../../services/string_validator.dart';

/// Password field used in the sign-up form.
class PasswordField extends BaseField {
  const PasswordField(
      {Key? key, required controller, required label, required hint})
      : super(key: key, controller: controller, label: label, hint: hint);

  @override
  PasswordFieldState createState() {
    return PasswordFieldState();
  }
}

class PasswordFieldState extends BaseFieldState {
  bool hidePassword = true;

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
        obscureText: hidePassword,
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          ValidatorMessage message = StringValidator.isValidPassword(value);
          if (message != ValidatorMessage.defaultMessage) {
            return StringValidator.getText(message);
          } else {
            return null;
          }
        },
        decoration: kTextFieldDecoration.copyWith(
          icon: const Icon(Icons.lock),
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
