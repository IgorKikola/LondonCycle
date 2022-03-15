import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cycle/pages/menu.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Profile',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.lightBlue,
      ),

    );
  }
}
