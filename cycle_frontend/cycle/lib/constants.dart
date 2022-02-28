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
  icon: Icon(Icons.person),
);

const kSubmitButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
);

const kFormFieldTooltipDecoration = BoxDecoration(
    color: Colors.black12,
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ));

const kFormFieldTooltipTextStyle = TextStyle(
  color: Colors.white70,
);
