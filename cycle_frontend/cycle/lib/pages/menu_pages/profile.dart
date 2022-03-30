import 'package:cycle/models/user_details_response_model.dart';
import 'package:flutter/material.dart';
import 'package:cycle/components/menu.dart';
import 'package:cycle/components/user_profile_row.dart';

class ProfilePage extends StatefulWidget {
  final UserDetailsResponseModel userData;
  ProfilePage({required this.userData});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                children: [
                  UserProfileRow(
                    title: "First name:",
                    value: widget.userData.firstName,
                  ),
                  UserProfileRow(
                    title: "Last name:",
                    value: widget.userData.lastName,
                  ),
                  UserProfileRow(
                    title: "Email:",
                    value: widget.userData.email,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
