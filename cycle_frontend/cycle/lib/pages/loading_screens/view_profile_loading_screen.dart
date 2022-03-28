import 'package:cycle/pages/edit_user_profile.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../components/menu_components/profile.dart';

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
    var userData = await UserDetailsHelper.userDetails();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProfilePage(
        userData: userData!,
      );
    }));
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
