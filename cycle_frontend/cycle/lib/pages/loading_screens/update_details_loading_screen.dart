import 'package:another_flushbar/flushbar.dart';
import 'package:cycle/models/signup_request_model.dart';
import 'package:cycle/models/update_profile_request_model.dart';
import 'package:cycle/models/update_profile_response_model.dart';
import 'package:cycle/pages/home_page.dart';
import 'package:cycle/pages/loading_screens/view_profile_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/api_service.dart';
import '../../services/user_details_helper.dart';
import '../signup_login_pages/login_page.dart';

class UpdateUserDetailsLoadingScreen extends StatefulWidget {
  final UpdateProfileRequestModel model;

  const UpdateUserDetailsLoadingScreen({required this.model});

  @override
  State<StatefulWidget> createState() {
    return _UpdateUserDetailsLoadingScreenState();
  }
}

class _UpdateUserDetailsLoadingScreenState
    extends State<UpdateUserDetailsLoadingScreen> {
  @override
  void initState() {
    super.initState();
    tryToUpdateUserDetails();
  }

  void tryToUpdateUserDetails() async {
    APIService.updateProfile(widget.model).then(
      (response) {
        if (response.statusCode == 200) {
          // Update was successful.
          UserDetailsHelper.updateUserDetails(response);
          //Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ViewProfileLoadingScreen();
          }));
          Flushbar(
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            duration: const Duration(seconds: 5),
            message: "Your details have been successfully updated.",
            flushbarStyle: FlushbarStyle.GROUNDED,
            titleText: const Text(
              "Success!",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ).show(context);
        } else {
          Navigator.pop(context);
          Flushbar(
            // Otherwise display a message at the bottom of the screen with the message
            // received from the API about what went wrong.
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
            flushbarStyle: FlushbarStyle.GROUNDED,
            titleText: const Text(
              "Update has been denied!",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            message:
                "${response.response[0].toUpperCase()}${response.response.substring(1).toLowerCase()}",
            duration: const Duration(seconds: 5),
          ).show(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
