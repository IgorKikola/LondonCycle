import 'package:another_flushbar/flushbar.dart';
import 'package:cycle/models/signup_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/api_service.dart';
import '../signup_login_pages/login_page.dart';

class SignupLoadingScreen extends StatefulWidget {
  final SignupRequestModel model;

  const SignupLoadingScreen({required this.model});

  @override
  State<StatefulWidget> createState() {
    return _SignupLoadingScreenState();
  }
}

class _SignupLoadingScreenState extends State<SignupLoadingScreen> {
  @override
  void initState() {
    super.initState();
    tryToSignup();
  }

  void tryToSignup() async {
    APIService.signup(widget.model).then(
      (response) {
        if (response.statusCode == 200) {
          // Redirect user to the login page.
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushNamed(context, LoginPage.id);
          Flushbar(
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            duration: const Duration(seconds: 5),
            message: "You can now log in.",
            titleText: const Text("Signup was successful!",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
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
            title: 'Sign-up was rejected!',
            message:
                "${response.response[0].toUpperCase()}${response.response.substring(1).toLowerCase()}",
            duration: const Duration(seconds: 5),
            flushbarStyle: FlushbarStyle.GROUNDED,
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
