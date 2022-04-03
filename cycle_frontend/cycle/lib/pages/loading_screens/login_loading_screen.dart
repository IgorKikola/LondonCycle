import 'package:another_flushbar/flushbar.dart';
import 'package:cycle/models/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/data_managers/user_data_manager.dart';
import '../home_page.dart';

class LoginLoadingScreen extends StatefulWidget {
  final LoginRequestModel model;

  const LoginLoadingScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginLoadingScreenState();
  }
}

class _LoginLoadingScreenState extends State<LoginLoadingScreen> {
  @override
  void initState() {
    super.initState();
    tryToLogin();
  }

  void tryToLogin() async {
    APIService.login(widget.model).then(
      (response) {
        if (response) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        } else {
          // If login was unsuccessful, show a bar for the user at the bottom of the screen.
          Navigator.pop(context);
          Flushbar(
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
            flushbarStyle: FlushbarStyle.GROUNDED,
            titleText: const Text(
              "Credentials are invalid!",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            message: 'Check if your email and password are correct.',
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
