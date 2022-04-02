import 'package:cycle/components/forms/edit_profile_form.dart';
import 'package:cycle/models/user_details_response_model.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  static const String id = 'edit_profile';
  final UserDetailsResponseModel userData;
  const EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Edit your details',
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                ),
                EditProfileForm(widget.userData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
