import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:flutter/material.dart';

import '../../components/menu.dart';

class SignUpOrLoginPage extends StatefulWidget {
  static const String id = 'sign_up_or_login_page';

  const SignUpOrLoginPage({Key? key}) : super(key: key);

  @override
  _SignUpOrLoginPageState createState() => _SignUpOrLoginPageState();
}

class _SignUpOrLoginPageState extends State<SignUpOrLoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      upperBound: 1.0,
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text(
          'My Profile',
          // style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('assets/images/bicycle.png'),
                    height: animation.value * 80,
                  ),
                ),
                const Text(
                  'Cycles',
                  style: TextStyle(
                    fontSize: 90.0,
                    fontFamily: 'Lobster',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomBlueButton(
                        text: "Signup",
                        onPressed: () =>
                            Navigator.pushNamed(context, SignupPage.id),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: CustomBlueButton(
                        text: "Login",
                        onPressed: () =>
                            Navigator.pushNamed(context, LoginPage.id),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
