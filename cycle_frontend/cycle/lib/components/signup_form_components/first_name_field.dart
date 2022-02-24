import 'package:flutter/material.dart';

/// First name field used in the sign-up form.
class FirstNameField extends StatefulWidget {
  const FirstNameField({Key? key}) : super(key: key);

  @override
  FirstNameFieldState createState() {
    return FirstNameFieldState();
  }
}

class FirstNameFieldState extends State<FirstNameField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? getErrorText() {
    // Value can be retrieved at any time.
    final text = _controller.value.text;
    if (text.isEmpty) {
      return 'This field cannot be empty.';
    }
    // return null if the text is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, TextEditingValue value, __) {
        return Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'First name',
              hintText: 'Enter your first name',
              errorText: getErrorText(),
            ),
          ),
        );
      },
    );
  }
}
