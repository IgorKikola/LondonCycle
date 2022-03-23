import 'package:csv/csv.dart';
import 'package:cycle/components/searchbox.dart';
import 'package:cycle/services/directions.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:cycle/utilities/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/navigation.dart';
import '../services/route.dart';
import '../animations/animate.dart';
import 'journey_stop_pages/journey_stops.dart';

final TextEditingController startingPointSearchboxTypeAheadController =
    TextEditingController();
final TextEditingController finishingPointSearchboxTypeAheadController =
    TextEditingController();

class SlideUpWidget extends StatefulWidget {
  final ScrollController controller;
  final mapRefreshCallback;
  final MyRoute myRoute = MyRouteProvider.myRoute;

  SlideUpWidget(
      {Key? key, required this.controller, required void mapRefreshCallback()})
      : mapRefreshCallback = mapRefreshCallback,
        super(key: key);

  @override
  State<SlideUpWidget> createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<SlideUpWidget> {
  // Coordinate myDefaultStartingPoint = Coordinate(latitude: 51.0, longitude: 0.1);

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
    return widget.myRoute.startingLocation != null &&
        widget.myRoute.finishingLocation != null;
  }

  Future<void> findRoute() async {
    print('finding route for...');
    if (widget.myRoute.startingLocation != null) {
      print('starting point: ${widget.myRoute.startingLocation}');
    }
    if (widget.myRoute.finishingLocation != null) {
      print('finishing point: ${widget.myRoute.finishingLocation}');
    }

    await DirectionsService.getCoordinatesForRoute(widget.myRoute);

    print('route found.');

    widget.mapRefreshCallback();
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
                  height: 180,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SearchBoxWidget(
                          searchBar: StartingLocationSearchBar(
                              myRoute: widget.myRoute),
                        ),
                        SizedBox(height: 10),
                        SearchBoxWidget(
                          searchBar: FinishingLocationSearchBar(
                              myRoute: widget.myRoute),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StopsWidget(),
                            SizedBox(width: 10),
                            Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Material(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15.0),
                                child: InkWell(
                                  splashColor: Colors.lightBlue,
                                  onTap: () {
                                    findRoute();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.search, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 30,
                              width: 60,
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
                                      backgroundColor: Colors.lightBlue[200],
                                      title: const Text(
                                        'Add riders',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: new TextField(
                                        controller: numController,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: new InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.white),
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
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                            changeText();
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
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
                                      // Text(
                                      //   'Riders:',
                                      //   key: Key('RiderText'),
                                      //   style: kSlideUpWidgetLabelTextStyle,
                                      // ),
                                      // SizedBox(width: 5),
                                      Container(
                                        //padding: EdgeInsets.only(right: 70),
                                        child: Text(
                                          num.toString(),
                                          key: Key('RiderValue'),
                                          style: kSlideUpWidgetLabelTextStyle,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Material(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15.0),
                            child: InkWell(
                              splashColor: Colors.lightBlue,
                              onTap: () {
                                Navigation navigation = Navigation();
                                navigation.navigate();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.flag_outlined,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                child: Material(
                  color: Colors.lightBlue,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BottomSectionLabel(labelText: 'Landm:'),
                                SizedBox(height: 10),
                                LandmarkItemWidget(landmarkName: 'Lon.'),
                                SizedBox(height: 10),
                                LandmarkItemWidget(landmarkName: 'Big Ben'),
                                SizedBox(height: 10),
                                LandmarkItemWidget(landmarkName: 'The Shard'),
                                SizedBox(height: 10),
                                LandmarkItemWidget(landmarkName: 'Tower...'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                              BottomSectionLabel(labelText: 'Bikepoints:'),
                              SizedBox(height: 10),
                              BikeStationItemWidget(
                                  bikeStationName: 'Horseferry Road'),
                              SizedBox(height: 10),
                              BikeStationItemWidget(
                                  bikeStationName: 'Westminister Pier'),
                              SizedBox(height: 10),
                              BikeStationItemWidget(
                                  bikeStationName: 'Vauxhall Bridge'),
                              SizedBox(height: 10),
                              BikeStationItemWidget(
                                  bikeStationName: 'Milbank Tower'),
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
                title: Text(
                  "Landmarks",
                  style: kSlideUpWidgetLandmarksAlertDialogTitleTextStyle,
                ),
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
                                  title: Text(
                                    data[index][1],
                                    style:
                                        kSlideUpWidgetLandmarksAlertDialogListTileTextStyle,
                                  ),
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

class LandmarkItemWidget extends StatefulWidget {
  LandmarkItemWidget({
    Key? key,
    required this.landmarkName,
  }) : super(key: key);

  Color starColor = Colors.grey;
  final String landmarkName;

  @override
  State<LandmarkItemWidget> createState() => _LandmarkItemWidgetState();
}

class _LandmarkItemWidgetState extends State<LandmarkItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            print(widget.landmarkName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sanitiseString(widget.landmarkName, 5),
                style: kSlideUpWidgetLeftBottomSectionItemTextStyle,
              ),
              IconButton(
                alignment: Alignment(1.0, 0),
                icon: Icon(Icons.star, color: widget.starColor),
                onPressed: () {
                  setState(() {
                    widget.starColor = widget.starColor == Colors.grey
                        ? Colors.yellow
                        : Colors.grey;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BikeStationItemWidget extends StatefulWidget {
  BikeStationItemWidget({
    Key? key,
    required this.bikeStationName,
  }) : super(key: key);

  final String bikeStationName;

  @override
  State<BikeStationItemWidget> createState() => _BikeStationItemWidgetState();
}

class _BikeStationItemWidgetState extends State<BikeStationItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            print(widget.bikeStationName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sanitiseString(widget.bikeStationName, 5),
                style: kSlideUpWidgetRightBottomSectionItemTextStyle,
              ),
              Text(
                '0.5 m.', //TODO: implement nearest bikepoints distances
                style: kSlideUpWidgetRightBottomSectionItemTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSectionLabel extends StatelessWidget {
  const BottomSectionLabel({
    Key? key,
    required this.labelText,
  }) : super(key: key);

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            sanitiseString(labelText, 5),
            style: kSlideUpWidgetBottomSectionLabelTextStyle,
          ),
        ],
      ),
    );
  }
}

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key? key,
    required this.searchBar,
  }) : super(key: key);

  final Widget searchBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: searchBar,
    );
  }
}

class StartingLocationSearchBar extends StatelessWidget {
  const StartingLocationSearchBar({
    Key? key,
    required this.myRoute,
  }) : super(key: key);

  final MyRoute myRoute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.my_location_rounded,
          color: Colors.red,
        ),
        SearchBox(
          searchboxType: Waypoint.START,
          myRoute: myRoute,
          typeAheadController: startingPointSearchboxTypeAheadController,
        ),
        // SizedBox(width: 32.0)
      ],
    );
  }
}

class FinishingLocationSearchBar extends StatelessWidget {
  const FinishingLocationSearchBar({
    Key? key,
    required this.myRoute,
  }) : super(key: key);

  final MyRoute myRoute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Colors.red,
        ),
        SearchBox(
          searchboxType: Waypoint.FINISH,
          myRoute: myRoute,
          typeAheadController: finishingPointSearchboxTypeAheadController,
        ),
        // SizedBox(width: 32.0)
      ],
    );
  }
}

class StopsWidget extends StatelessWidget {
  const StopsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 130,
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
              MaterialPageRoute(builder: (context) => JourneyStops()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.add_location_alt, color: Colors.red),
              Text(
                'Stops',
                style: kSlideUpWidgetLabelTextStyle,
              ),
              SizedBox(width: 10.0)
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: make string somehow adaptable to the available space
String sanitiseString(String string, int maxLength) =>
    string.length >= maxLength
        ? string.substring(0, maxLength - 1) + '...'
        : string;
