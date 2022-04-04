import 'package:cycle/components/custom_blue_button.dart';
import 'package:cycle/pages/signup_login_pages/login_page.dart';
import 'package:cycle/pages/signup_login_pages/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///Landing page after user logs out
class StartingPage extends StatefulWidget {
  static const String id = 'starting_page';

  const StartingPage({Key? key}) : super(key: key);

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage>
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
                const SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Continue as a guest",
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lobster',
                          fontSize: 18.0,
                          //decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
