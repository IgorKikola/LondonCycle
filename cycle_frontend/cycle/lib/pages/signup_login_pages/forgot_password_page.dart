import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String id = 'forgot_password_page';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remind me my password'),
      ),
      body: const Center(child: Text('To be implemented...')),
    );
  }
}
