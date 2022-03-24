import 'package:cycle/constants.dart';
import 'package:flutter/material.dart';

class CustomBlueButton extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const CustomBlueButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: kCustomBlueButtonStyle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        child: Text(text, style: kCustomBlueButtonTextStyle),
      ),
    );
  }
}
