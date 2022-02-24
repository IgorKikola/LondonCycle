import 'package:flutter/material.dart';

class AttractionMarker extends StatelessWidget {
  final String title;

  const AttractionMarker({required this.title});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      child: const Icon(
        Icons.account_balance,
        color: Color(0xFFFFC43D),
      ),
      message: title,
    );
  }
}
