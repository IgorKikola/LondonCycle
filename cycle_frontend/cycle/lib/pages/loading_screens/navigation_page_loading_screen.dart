import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NavigationPageLoadingScreen extends StatefulWidget {
  final Function action;
  const NavigationPageLoadingScreen({Key? key, required this.action})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavigationPageLoadingScreenState();
  }
}

class _NavigationPageLoadingScreenState
    extends State<NavigationPageLoadingScreen> {
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
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
