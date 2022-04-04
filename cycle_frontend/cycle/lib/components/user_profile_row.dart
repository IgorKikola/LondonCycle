import 'package:flutter/material.dart';

class UserProfileRow extends StatelessWidget {
  final String value;

  const UserProfileRow({Key? key, required this.value}) : super(key: key);

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
