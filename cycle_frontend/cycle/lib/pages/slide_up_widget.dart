import 'package:csv/csv.dart';
import 'package:cycle/components/searchbox.dart';
import 'package:cycle/services/directions.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/route.dart';
import '../animations/animate.dart';
import 'journey_stops.dart';

final TextEditingController startingPointSearchboxTypeAheadController =
    TextEditingController();
final TextEditingController finishingPointSearchboxTypeAheadController =
    TextEditingController();

class SlideUpWidget extends StatefulWidget {
  final ScrollController controller;

  SlideUpWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<SlideUpWidget> createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<SlideUpWidget> {
  // Coordinate myDefaultStartingPoint = Coordinate(latitude: 51.0, longitude: 0.1);
  MyRoute myRoute = MyRoute();

  Color star1Color = Colors.grey;
  Color star2Color = Colors.grey;
  Color star3Color = Colors.grey;
  Color star4Color = Colors.grey;
  List<List<dynamic>> data = [];

  var numController = TextEditingController();
  var num = 0;

  changeText() {
    setState(() {
      num = int.parse(numController.text);
    });
  }

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/landmarks.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      data = _listData;
    });
  }

  bool isRouteComplete() {
    return myRoute.startingLocation != null &&
        myRoute.finishingLocation != null;
  }

  void findRoute() {
    print('finding route for...');
    if (myRoute.startingLocation != null) {
      print('starting point: ${myRoute.startingLocation}');
    }
    if (myRoute.finishingLocation != null) {
      print('finishing point: ${myRoute.finishingLocation}');
    }

    DirectionsService.getInstructionsForRoute(myRoute);
    print('route found.');
  }

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
        physics: const NeverScrollableScrollPhysics(),
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
      child: Padding(
          padding: EdgeInsets.zero,
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
                        height: 30,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.my_location_rounded, color: Colors.red),
                            SearchBox(
                                searchboxType: Waypoint.START,
                                myRoute: myRoute,
                                typeAheadController:
                                    startingPointSearchboxTypeAheadController),
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
                            SearchBox(
                              searchboxType: Waypoint.FINISH,
                              myRoute: myRoute,
                              typeAheadController:
                                  finishingPointSearchboxTypeAheadController,
                            ),
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
                            width: 110,
                            key: Key('RiderContainer'),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[200],
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Material(
                              color: Colors.lightBlue[200],
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                splashColor: Colors.lightBlue,
                                onTap: () => {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Add riders'),
                                      content: new TextField(
                                        controller: numController,
                                        decoration: new InputDecoration(
                                            labelText:
                                                "Enter the number of riders."),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                            changeText();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  changeText(),
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.person_add,
                                        key: Key('RiderIcon'),
                                        color: Colors.red),
                                    Text('Riders:',
                                        key: Key('RiderText'),
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    Container(
                                        padding: EdgeInsets.only(right: 70),
                                        child: Text(num.toString(),
                                            key: Key('RiderValue'),
                                            style: GoogleFonts.lato(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white))),
                                    Text('Stops',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    SizedBox(width: 20.0)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Material(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                splashColor: Colors.lightBlue,
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.search, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[200],
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Material(
                              color: Colors.lightBlue[200],
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                splashColor: Colors.lightBlue,
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.directions_bike,
                                        color: Colors.red),
                                    Text('Riders',
                                        style: GoogleFonts.lato(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white)),
                                    SizedBox(width: 20.0)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )));

  Widget buildWidgetGrid() => Container(
        padding: EdgeInsets.all(1.0),
        alignment: Alignment(-1.0, 0.0),
        constraints: BoxConstraints.tightForFinite(height: 400, width: 200),
        height: 400,
        width: 200,
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
                      child: InkWell(
                          splashColor: Colors.lightBlue,
                          onTap: () {
                            showLandmarks(context);
                            setState(() {
                              _loadCSV();
                            });
                          },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.lightBlueAccent,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(20.0)),

                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // children: [

                                        child: Material(
                                          color: Colors.lightBlue[200],
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          child: InkWell(
                                            splashColor: Colors.lightBlue,
                                            onTap: () {
                                              print("London Eye");
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('London Eye',
                                                    style: GoogleFonts.lato(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white)),
                                                new IconButton(
                                                  alignment: Alignment(1.0, 0),
                                                  icon: Icon(Icons.star,
                                                      color: star1Color),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (star1Color ==
                                                          Colors.grey) {
                                                        star1Color =
                                                            Colors.yellow;
                                                      } else {
                                                        star1Color =
                                                            Colors.grey;
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
                                            borderRadius:
                                                BorderRadius.circular(20.0)),

                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // children: [

                                        child: Material(
                                          color: Colors.lightBlue[200],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: InkWell(
                                            splashColor: Colors.lightBlue,
                                            onTap: () {
                                              print("Big Ben");
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Big Ben',
                                                    style: GoogleFonts.lato(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white)),
                                                new IconButton(
                                                  alignment: Alignment(1.0, 0),
                                                  icon: Icon(Icons.star,
                                                      color: star2Color),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (star2Color ==
                                                          Colors.grey) {
                                                        star2Color =
                                                            Colors.yellow;
                                                      } else {
                                                        star2Color =
                                                            Colors.grey;
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
                                            borderRadius:
                                                BorderRadius.circular(20.0)),

                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // children: [

                                        child: Material(
                                          color: Colors.lightBlue[200],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: InkWell(
                                            splashColor: Colors.lightBlue,
                                            onTap: () {
                                              print("The Shard");
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('The Shard',
                                                    style: GoogleFonts.lato(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white)),
                                                new IconButton(
                                                  alignment: Alignment(1.0, 0),
                                                  icon: Icon(Icons.star,
                                                      color: star3Color),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (star3Color ==
                                                          Colors.grey) {
                                                        star3Color =
                                                            Colors.yellow;
                                                      } else {
                                                        star3Color =
                                                            Colors.grey;
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
                                            borderRadius:
                                                BorderRadius.circular(20.0)),

                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        // children: [

                                        child: Material(
                                          color: Colors.lightBlue[200],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: InkWell(
                                            splashColor: Colors.lightBlue,
                                            onTap: () {
                                              print("Tower Bridge");
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Tower Bridge',
                                                    style: GoogleFonts.lato(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white)),
                                                new IconButton(
                                                  alignment: Alignment(1.0, 0),
                                                  icon: Icon(Icons.star,
                                                      color: star4Color),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (star4Color ==
                                                          Colors.grey) {
                                                        star4Color =
                                                            Colors.yellow;
                                                      } else {
                                                        star4Color =
                                                            Colors.grey;
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
                          )))),
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
                                          // Text('0.5 miles away',
                                          //     style: GoogleFonts.lato(
                                          //         fontSize: 10,
                                          //         fontStyle: FontStyle.normal,
                                          //         color: Colors.white)),
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
                                          // Text('1.5 miles away',
                                          //     style: GoogleFonts.lato(
                                          //         fontSize: 10,
                                          //         fontStyle: FontStyle.normal,
                                          //         color: Colors.white)),
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
                                          // Text('2 miles away',
                                          //     style: GoogleFonts.lato(
                                          //         fontSize: 10,
                                          //         fontStyle: FontStyle.normal,
                                          //         color: Colors.white)),
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
                                          // Text('2.5 miles away',
                                          //     style: GoogleFonts.lato(
                                          //         fontSize: 10,
                                          //         fontStyle: FontStyle.normal,
                                          //         color: Colors.white)),
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

  Future<dynamic> showLandmarks(BuildContext context) async {
    return showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
          return Animations.grow(_animation, _secondaryAnimation, _child);
        },
        pageBuilder: (_animation, _secondaryAnimation, _child) {
          // return showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text("Landmarks",
                    style: GoogleFonts.lato(color: Colors.white)),
                backgroundColor: Colors.lightBlueAccent,
                content: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Divider(),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.4,
                          ),
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (_, index) {
                              return Card(
                                margin: const EdgeInsets.all(3),
                                color: Colors.lightBlue[200],
                                child: ListTile(
                                  title: Text(data[index][1],
                                      style: GoogleFonts.lato(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white)),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     ElevatedButton(
                  //         style: ButtonStyle(
                  //           backgroundColor:
                  //           MaterialStateProperty.all<Color>(Colors.red),
                  //         ),
                  //         onPressed: () {
                  //           setState(() {
                  //             _loadCSV();
                  //           });
                  //         },
                  //         child: Icon(Icons.add_circle)),
                  //
                  //   ],
                  // )
                ],
              );
            },
          );
        });
  }
}
