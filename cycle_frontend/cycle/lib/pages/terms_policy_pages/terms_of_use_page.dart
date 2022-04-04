import 'package:flutter/material.dart';

class TermsOfUsePage extends StatefulWidget {
  static const String id = 'terms_of_use_page';

  const TermsOfUsePage({Key? key}) : super(key: key);

  @override
  _TermsOfUsePageState createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms Of Use'),
      ),
      body: const Center(child: Text('No information yet.')),
    );
  }
}
