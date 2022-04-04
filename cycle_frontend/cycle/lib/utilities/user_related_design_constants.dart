import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  labelText: '',
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  icon: null,
);

const kCustomBlueButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontFamily: 'Lobster',
);

const kFormFieldTooltipDecoration = BoxDecoration(
    color: Colors.black12,
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ));

const kFormFieldTooltipTextStyle = TextStyle(
  color: Colors.white70,
);

ButtonStyle kCustomBlueButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(32.0),
      ),
      side: BorderSide(color: Colors.white),
    ),
  ),
);
