import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/models/user_details_response_model.dart';
import 'package:cycle/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:cycle/components/menu.dart';

import '../../services/user_details_helper.dart';
import '../../pages/loading_screens/edit_profile_loading_screen.dart';

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

class UserProfileRow extends StatelessWidget {
  const UserProfileRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }
}
