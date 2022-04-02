import 'package:cycle/utilities/home_page_design_contants.dart';
import 'package:flutter/material.dart';
import 'package:cycle/components/menu.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
