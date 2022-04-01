import 'package:cycle/utilities/constants-sign-up-login.dart';
import 'package:flutter/material.dart';

class CustomBlueButton extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const CustomBlueButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: kCustomBlueButtonStyle,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text(text, style: kCustomBlueButtonTextStyle),
        ),
      ),
    );
  }
}
