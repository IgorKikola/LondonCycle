import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  static const String id = 'privacy_policy_page';

  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const Center(child: Text('No information yet.')),
    );
  }
}
