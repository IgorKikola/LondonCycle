import 'package:flutter/material.dart';

import 'pages/main_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/pages/menu.dart';
import 'package:google_fonts/google_fonts.dart';

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
        drawer: Menu(),
        appBar: AppBar(
          title: Text('Map',
              style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
          backgroundColor: Colors.lightBlue,
        ),
        body: SlidingUpPanel(
          color: Colors.lightBlue,
          minHeight: 155,
          maxHeight: 420,
          parallaxEnabled: true,
          parallaxOffset: 1.0,
          isDraggable: true,
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
