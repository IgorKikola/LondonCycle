import 'package:flutter/material.dart';

/// Base field.
abstract class BaseField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;

  const BaseField(
      {Key? key, this.controller, required this.label, required this.hint})
      : super(key: key);
}

abstract class BaseFieldState extends State<BaseField> {
  @override
  void dispose() {
    super.dispose();
  }
}
