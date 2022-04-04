import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../pages/menu_pages/profile.dart';

class ViewProfileLoadingScreen extends StatefulWidget {
  const ViewProfileLoadingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewProfileLoadingScreenState();
  }
}

class _ViewProfileLoadingScreenState extends State<ViewProfileLoadingScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    var userLoggedIn = await UserDetailsHelper.isLoggedIn();
    if (userLoggedIn) {
      var userData = await UserDetailsHelper.userDetails();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ProfilePage(
          userData: userData!,
        );
      }));
    } else {
      Navigator.pushReplacementNamed(context, SignupPage.id);
    }
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
