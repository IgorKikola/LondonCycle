import 'package:flutter/material.dart';

import 'main_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/pages/menu.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<MainPageState> _myMainPageState = GlobalKey<MainPageState>();

  void myHomePageMapRefresh() {
    print('my myHomePageMapRefresh called.');
    print('now trying to call myMapRefresh() on _myMainPageState...');
    _myMainPageState.currentState?.myMapRefresh();
    print('refreshed _myMainPageState.');
  }

  @override
  Widget build(BuildContext context) {
    print('home_page(app) build called.');

    return MaterialApp(
      home: Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          title: Text('Map',
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
          backgroundColor: Colors.lightBlue,
        ),
        body: SlidingUpPanel(
          color: Colors.lightBlue,
          minHeight: 185,
          maxHeight: 450,
          parallaxEnabled: true,
          parallaxOffset: 1.0,
          isDraggable: true,
          backdropTapClosesPanel: true,
          body: MainPage(key: _myMainPageState),
          panelBuilder: (controller) => SlideUpWidget(
            controller: controller,
            mapRefreshCallback: myHomePageMapRefresh,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
      ),
    );
  }
}
