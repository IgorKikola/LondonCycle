import 'package:flutter/material.dart';

import 'main_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cycle/pages/slide_up_widget.dart';
import 'package:cycle/pages/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cycle/components/searchbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          title: Text('Map',
              style:
                  GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
          backgroundColor: Colors.lightBlue,
        ),
        body: Column(
          children: [
            Container(
              color: Colors.lightBlue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SearchBox().getSearchBox(),
                    MaterialButton(
                      child: const Icon(Icons.search),
                      minWidth: 150.0,
                      color: Colors.red,
                      onPressed: () {
                        print('pressed');
                      },
                    ),
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
              color: Colors.lightBlue,
              minHeight: 185,
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
          ],
        ),
      ),
    );
  }
}
