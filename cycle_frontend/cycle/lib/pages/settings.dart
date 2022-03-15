import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text('Settings',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.lightBlue,
      ),

    );
  }
}
