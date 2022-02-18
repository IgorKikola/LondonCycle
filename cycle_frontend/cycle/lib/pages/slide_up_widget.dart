import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideUpWidget extends StatelessWidget {
  final ScrollController controller;

  SlideUpWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        controller: controller,
        children: <Widget>[
          buildSlidingHandle(),
          SizedBox(height: 10),
          buildSearchBar(),
          SizedBox(height: 10),
          buildWidgetGrid(),
        ],
      );

  Widget buildSlidingHandle() => GestureDetector(
    child: Center(
      child: Container(
        width: 30,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
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
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 30,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[200],
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
                        color: Colors.lightBlue[200],
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

  Widget buildWidgetGrid() => Container(
    padding: EdgeInsets.all(1.0),
    alignment: Alignment(-1.0, 0.0),
    // constraints: BoxConstraints.tightForFinite(height: 400, width: 200),
    height: 800,
    width: 800,
    child: GridView.count(
      padding: EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 0.5,
      children: [
        Center(
          widthFactor: 300,
          heightFactor: 400,
          child: Container(
              padding: EdgeInsets.all(1.0),
              alignment: Alignment(1.0, 0.0),
              child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          height: 230,
                          width: 190,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Landmarks:',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Big Ben',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tower Bridge',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Icon(Icons.star,
                                        color: Colors.black.withOpacity(0.2)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('London Eye',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Icon(Icons.star, color: Colors.yellow),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('The Shard',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Icon(Icons.star,
                                        color: Colors.black.withOpacity(0.2)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))),
        ),
        Center(
          widthFactor: 300,
          heightFactor: 400,
          child: Container(
              padding: EdgeInsets.all(1.0),
              alignment: Alignment(-1.0, 0.0),
              child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          height: 230,
                          width: 190,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Nearest Collection Points:',
                                        style: GoogleFonts.lato(
                                            fontSize: 13,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Horseferry Road',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Text('0.5 miles away',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Westminister Pier',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Text('1.5 miles away',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Vauxhall Bridge',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Text('2 miles away',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Milbank Tower',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Text('2.5 miles away',
                                        style: GoogleFonts.lato(
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))),
        ),
      ],
    ),
  );
}
