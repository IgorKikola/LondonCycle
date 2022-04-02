import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NavigationLoadingScreen extends StatefulWidget {
  final Function action;
  const NavigationLoadingScreen({Key? key, required this.action})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavigationLoadingScreenState();
  }
}

class _NavigationLoadingScreenState extends State<NavigationLoadingScreen> {
  @override
  void initState() {
    super.initState();
    computeActionAndCloseScreen();
  }

  void computeActionAndCloseScreen() async {
    await widget.action();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
