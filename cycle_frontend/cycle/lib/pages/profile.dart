import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/models/user_details_response_model.dart';
import 'package:cycle/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:cycle/pages/menu.dart';

import '../services/user_details_helper.dart';
import 'loading_screens/edit_profile_loading_screen.dart';

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
    print(widget.userData.firstName);
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
      body: Column(
        children: [
          Row(
            children: [
              Text(
                "First name:",
              ),
              Text(
                widget.userData.firstName,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Last name:",
              ),
              Text(
                widget.userData.lastName,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "First name:",
              ),
              Text(
                widget.userData.email,
              ),
            ],
          ),
          CustomBlueButton(
              text: "Edit profile details",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EditProfileLoadingScreen();
                }));
              })
        ],
      ),
    );
  }
}
