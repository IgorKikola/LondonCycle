import 'package:cycle/utilities/constants.dart';
import 'package:flutter/material.dart';
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
        title: Text(
          'Profile',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
