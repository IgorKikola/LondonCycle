import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'journey_stops.dart';
import 'package:cycle/components/searchbox.dart';

class SlideUpWidget extends StatefulWidget {
  final ScrollController controller;

  SlideUpWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<SlideUpWidget> createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<SlideUpWidget> {
  Color star1Color = Colors.grey;
  Color star2Color = Colors.grey;
  Color star3Color = Colors.grey;
  Color star4Color = Colors.grey;

  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          SizedBox(height: 10),
          buildSlidingHandle(),
          SizedBox(height: 10),
          buildSearchBar(context),
          SizedBox(height: 5),
          buildWidgetGrid(),
        ],
        controller: widget.controller,
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

  Widget buildSearchBar(BuildContext context) => Container(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(1),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  height: 150,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.my_location_rounded, color: Colors.red),
                            SearchBox().getSearchBox(),
                            SizedBox(width: 32.0)
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 30,
                        width: 300,
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
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[200],
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Material(
                              color: Colors.lightBlue[200],
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                splashColor: Colors.lightBlue,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const JourneyStops()),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.add_location_alt,
                                        color: Colors.red),
                                    Text('"Add stops"',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    SizedBox(width: 32.0)
                                  ],
                                ),

                                // child: Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Column(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Container(
                                //           height: 30,
                                //           width: 300,
                                //           decoration: BoxDecoration(
                                //               color: Colors.lightBlue[200],
                                //               borderRadius: BorderRadius.circular(15.0)),
                                //           child: Row(
                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               Icon(Icons.my_location_rounded, color: Colors.red),
                                //               Text('"Current Location"',
                                //                   style: GoogleFonts.lato(
                                //                       fontStyle: FontStyle.normal,
                                //                       color: Colors.white)),
                                //               SizedBox(width: 32.0)
                                //             ],
                                //           ),
                                //         ),
                                //         SizedBox(height: 10),
                                //         Container(
                                //           height: 30,
                                //           width: 300,
                                //           decoration: BoxDecoration(
                                //               color: Colors.lightBlue[200],
                                //               borderRadius: BorderRadius.circular(15.0)),
                                //           child: Row(
                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               Icon(Icons.location_on_outlined, color: Colors.red),
                                //               Text('"Destination"',
                                //                   style: GoogleFonts.lato(
                                //                       fontStyle: FontStyle.normal,
                                //                       color: Colors.white)),
                                //               SizedBox(width: 32.0)
                                //             ],
                                //           ),
                                //         ),
                                //         SizedBox(height: 10),
                                //         Row(
                                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //           children: [
                                //             Container(
                                //               height: 30,
                                //               width: 170,
                                //               decoration: BoxDecoration(
                                //                   color: Colors.lightBlue[200],
                                //                   borderRadius: BorderRadius.circular(15.0)),
                                //               child: Material(
                                //                 color: Colors.lightBlue[200],
                                //                 borderRadius: BorderRadius.circular(15.0),
                                //                 child: InkWell(
                                //                   splashColor: Colors.lightBlue,
                                //                   onTap: () {
                                //                     Navigator.push(
                                //                       context,
                                //                       MaterialPageRoute(builder: (context) => const JourneyStops()),
                                //                     );
                                //                   },
                                //                   child: Row(
                                //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                     children: [
                                //                       Icon(Icons.add_location_alt, color: Colors.red),
                                //                       Text('"Add stops"',
                                //                           style: GoogleFonts.lato(
                                //                               fontStyle: FontStyle.normal,
                                //                               color: Colors.white)),
                                //                       SizedBox(width: 32.0)
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //             // SizedBox(width: 50),
                                //
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //     Container(
                                //       height: 55,
                                //       width: 55,
                                //       decoration: BoxDecoration(
                                //           color: Colors.red,
                                //           borderRadius: BorderRadius.circular(15.0)),
                                //       child:
                                //       Material(
                                //         color: Colors.red,
                                //         borderRadius: BorderRadius.circular(15.0),
                                //         child: InkWell(
                                //           splashColor: Colors.redAccent,
                                //           onTap: () {
                                //             print("Navigate");
                                //           },
                                //           child:
                                //           Transform.rotate(angle: -35 * 3.14 / 180,
                                //             child: Icon(Icons.directions_bike_rounded, size: 40,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

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
                  padding: EdgeInsets.all(6.0),
                  alignment: Alignment(1.0, 0.0),
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          height: 250,
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
                                padding: EdgeInsets.only(left: 2),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),

                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // children: [

                                child: Material(
                                  color: Colors.lightBlue[200],
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: InkWell(
                                    splashColor: Colors.lightBlue,
                                    onTap: () {
                                      print("London Eye");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('London Eye',
                                            style: GoogleFonts.lato(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white)),
                                        new IconButton(
                                          alignment: Alignment(1.0, 0),
                                          icon: Icon(Icons.star,
                                              color: star1Color),
                                          onPressed: () {
                                            setState(() {
                                              if (star1Color == Colors.grey) {
                                                star1Color = Colors.yellow;
                                              } else {
                                                star1Color = Colors.grey;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Text('Big Ben',
                              //     style: GoogleFonts.lato(
                              //         fontStyle: FontStyle.normal,
                              //         color: Colors.white)),
                              // Icon(Icons.star, color: Colors.yellow),
                              // ],
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 2),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),

                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // children: [

                                child: Material(
                                  color: Colors.lightBlue[200],
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: InkWell(
                                    splashColor: Colors.lightBlue,
                                    onTap: () {
                                      print("Big Ben");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Big Ben',
                                            style: GoogleFonts.lato(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white)),
                                        new IconButton(
                                          alignment: Alignment(1.0, 0),
                                          icon: Icon(Icons.star,
                                              color: star2Color),
                                          onPressed: () {
                                            setState(() {
                                              if (star2Color == Colors.grey) {
                                                star2Color = Colors.yellow;
                                              } else {
                                                star2Color = Colors.grey;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 2),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),

                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // children: [

                                child: Material(
                                  color: Colors.lightBlue[200],
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: InkWell(
                                    splashColor: Colors.lightBlue,
                                    onTap: () {
                                      print("The Shard");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('The Shard',
                                            style: GoogleFonts.lato(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white)),
                                        new IconButton(
                                          alignment: Alignment(1.0, 0),
                                          icon: Icon(Icons.star,
                                              color: star3Color),
                                          onPressed: () {
                                            setState(() {
                                              if (star3Color == Colors.grey) {
                                                star3Color = Colors.yellow;
                                              } else {
                                                star3Color = Colors.grey;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.only(left: 2),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),

                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // children: [

                                child: Material(
                                  color: Colors.lightBlue[200],
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: InkWell(
                                    splashColor: Colors.lightBlue,
                                    onTap: () {
                                      print("Tower Bridge");
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Tower Bridge',
                                            style: GoogleFonts.lato(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white)),
                                        new IconButton(
                                          alignment: Alignment(1.0, 0),
                                          icon: Icon(Icons.star,
                                              color: star4Color),
                                          onPressed: () {
                                            setState(() {
                                              if (star4Color == Colors.grey) {
                                                star4Color = Colors.yellow;
                                              } else {
                                                star4Color = Colors.grey;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
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
                        padding: EdgeInsets.all(6),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          height: 250,
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
                                    Text('Bike Points:',
                                        style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Material(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: InkWell(
                                      splashColor: Colors.lightBlue,
                                      onTap: () {
                                        print("Horseferry Road");
                                      },
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
                                    )),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Material(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: InkWell(
                                      splashColor: Colors.lightBlue,
                                      onTap: () {
                                        print("Westminister Pier");
                                      },
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
                                    )),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Material(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: InkWell(
                                      splashColor: Colors.lightBlue,
                                      onTap: () {
                                        print("Vauxhall Bridge");
                                      },
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
                                    )),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.all(2.0),
                                height: 35,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Material(
                                    color: Colors.lightBlue[200],
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: InkWell(
                                      splashColor: Colors.lightBlue,
                                      onTap: () {
                                        print("Milbank Tower");
                                      },
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
                                    )),
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
