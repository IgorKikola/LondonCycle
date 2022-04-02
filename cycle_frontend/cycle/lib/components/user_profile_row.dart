import 'package:flutter/material.dart';

class UserProfileRow extends StatelessWidget {
  const UserProfileRow({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
