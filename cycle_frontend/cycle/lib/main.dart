import 'package:flutter/material.dart';

import 'pages/main_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cycle/pages/slide_up_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SlidingUpPanel(
          color: Colors.lightBlue,
          minHeight: 170,
          maxHeight: 450,
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          body: MainPage(),
          panelBuilder: (controller) => SlideUpWidget(
            controller: controller,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
      ),
    );
  }
}
