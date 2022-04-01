import 'package:cycle/pages/edit_user_profile_page.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditProfileLoadingScreen extends StatefulWidget {
  const EditProfileLoadingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditProfileLoadingScreenState();
  }
}

class _EditProfileLoadingScreenState extends State<EditProfileLoadingScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    var userData = await UserDetailsHelper.userDetails();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditProfilePage(
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
