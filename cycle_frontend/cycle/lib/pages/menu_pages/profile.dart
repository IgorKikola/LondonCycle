import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/components/menu.dart';
import 'package:cycle/components/user_profile_row.dart';
import 'package:cycle/models/user_details_response_model.dart';
import 'package:cycle/pages/loading_screens/edit_profile_loading_screen.dart';
import 'package:cycle/pages/starting_page.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final UserDetailsResponseModel userData;

  const ProfilePage({Key? key, required this.userData}) : super(key: key);

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
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    UserProfileRow(
                      value: widget.userData.firstName,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    UserProfileRow(
                      value: widget.userData.lastName,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    UserProfileRow(
                      value: widget.userData.email,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                CustomBlueButton(
                  text: "Edit profile",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const EditProfileLoadingScreen();
                    }));
                  },
                ),
                const SizedBox(height: 10.0),
                CustomBlueButton(
                  text: "Log out",
                  onPressed: () {
                    UserDetailsHelper.logout(context);
                    Navigator.popUntil(context, ModalRoute.withName('home_page'));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return const StartingPage();
                        }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
