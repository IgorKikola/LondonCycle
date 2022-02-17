import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideUpWidget extends StatelessWidget {
  final ScrollController controller;

  SlideUpWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        controller: controller,
        children: <Widget>[
          buildSearchBar(),
        ],
      );

  Widget buildSearchBar() => Container(
          child: Container(
              child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: 120,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 30,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.my_location_rounded, color: Colors.red),
                        Text('"Current Location"',
                            style: GoogleFonts.lato(
                                fontStyle: FontStyle.normal,
                                color: Colors.white)),
                        SizedBox(width: 32.0)
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 30,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.red),
                        Text('"Destination"',
                            style: GoogleFonts.lato(
                                fontStyle: FontStyle.normal,
                                color: Colors.white)),
                        SizedBox(width: 32.0)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )));
}
