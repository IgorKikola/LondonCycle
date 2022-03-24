import 'package:cycle/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:cycle/pages/menu.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
