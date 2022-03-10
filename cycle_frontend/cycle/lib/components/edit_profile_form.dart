import 'package:cycle/components/form_fields/email_field.dart';
import 'package:cycle/components/form_fields/first_name_field.dart';
import 'package:cycle/components/form_fields/last_name_field.dart';
import 'package:cycle/components/form_fields/password_field.dart';
import 'package:cycle/components/form_fields/password_repeat_field.dart';
import 'package:flutter/material.dart';

import 'form_button.dart';

/// Form for editing user profile.
class EditProfileForm extends StatefulWidget {
  final Map userData;

  const EditProfileForm(this.userData, {Key? key}) : super(key: key);

  @override
  EditProfileFormState createState() {
    return EditProfileFormState();
  }
}

class EditProfileFormState extends State<EditProfileForm> {
  // Global key that uniquely identifies the EditProfileForm widget.
  final _formKey = GlobalKey<FormState>();

  // Controllers that keep track of the user's input.
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Wrap(
                runSpacing: 20.0,
                children: <Widget>[
                  FirstNameField(
                    controller: firstNameController,
                    initialText: widget.userData['firstName'],
                    label: 'New first name',
                    hint: 'Enter your first name',
                  ),
                  LastNameField(
                    controller: lastNameController,
                    initialText: widget.userData['lastName'],
                    label: 'New last name',
                    hint: 'Enter your last name',
                  ),
                  EmailField(
                    controller: emailController,
                    initialText: widget.userData['email'],
                    label: 'New email',
                    hint: 'Enter your new email address',
                  ),
                  PasswordField(
                    controller: passwordController,
                    label: 'New Password',
                    hint: 'Enter your new password',
                  ),
                  PasswordRepeatField(
                    passwordController: passwordController,
                    repeatPasswordController: repeatPasswordController,
                    label: 'Repeat your new password',
                    hint: 'Repeat your new password',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: FormButton(
                text: 'Update',
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    //_formKey.currentState.save();
                    // Update user details in the server.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
