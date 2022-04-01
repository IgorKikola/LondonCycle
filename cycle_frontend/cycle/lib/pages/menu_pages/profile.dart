import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/models/user_details_response_model.dart';
import 'package:cycle/pages/loading_screens/edit_profile_loading_screen.dart';
import 'package:cycle/pages/starting_page.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';
import 'package:cycle/components/menu.dart';
import 'package:cycle/components/user_profile_row.dart';

class ProfilePage extends StatefulWidget {
  final UserDetailsResponseModel userData;
  const ProfilePage({required this.userData});

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
          child: Column(
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
              CustomBlueButton(
                text: "Edit profile",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const EditProfileLoadingScreen();
                  }));
                },
              ),
              const SizedBox(height: 10.0),
              CustomBlueButton(
                text: "Log out",
                onPressed: () {
                  UserDetailsHelper.logout(context);
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const StartingPage();
                  }), (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
