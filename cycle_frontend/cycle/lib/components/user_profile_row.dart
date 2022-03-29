import 'package:flutter/material.dart';

class UserProfileRow extends StatelessWidget {
  const UserProfileRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
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
