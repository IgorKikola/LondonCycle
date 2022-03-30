import 'package:csv/csv.dart';
import 'package:cycle/components/searchbox.dart';
import 'package:cycle/pages/main_page.dart';
import 'package:cycle/services/coordinate.dart';
import 'package:cycle/services/routing.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:cycle/services/search_suggestions.dart';
import 'package:cycle/utilities/constants.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/journey_stop_pages/stored_stops.dart';
import '../services/mapcontroller_provider.dart';
import '../services/route.dart';
import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

  late List<GlobalKey<_BikeStationItemWidgetState>>
      globalBikeStationWidgetItemsKeys =
      _createGlobalBikeStationWidgetItemsKeys(4);

  void myBikeStationItemWidgetStateRefresh() {
    for (GlobalKey<_BikeStationItemWidgetState> item
        in globalBikeStationWidgetItemsKeys) {
      item.currentState?.myBikeStationItemWidgetRefresh();
    }
  }

  var riderNumController = TextEditingController();
  var numOfRiders = 1;

  void updateNumberOfRiders() {
    setState(() {
      if (int.parse(riderNumController.text) > 5) {
        numOfRiders = 5;
      } else if (int.parse(riderNumController.text) > 0) {
        numOfRiders = int.parse(riderNumController.text);
      } else {
        numOfRiders = 1;
      }
    });
  }

  List<GlobalKey<_BikeStationItemWidgetState>>
      _createGlobalBikeStationWidgetItemsKeys(int numberOfKeys) {
    List<GlobalKey<_BikeStationItemWidgetState>> returnKeys =
        List.empty(growable: true);
    for (int i = 0; i < numberOfKeys; i++) {
      returnKeys.add(_createGlobalKeyForBikeStationWidgetItem());
    }
    return returnKeys;
  }

  GlobalKey<_BikeStationItemWidgetState>
      _createGlobalKeyForBikeStationWidgetItem() {
    return GlobalKey<_BikeStationItemWidgetState>();
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

    await RoutingService.updateCoordinatesForRoute(widget.myRoute);

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

  Widget buildSearchBar(BuildContext context) => Padding(
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
                child: Material(
                  color: Colors.lightBlueAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SearchBoxWidget(
                        searchBar:
                            StartingLocationSearchBar(myRoute: widget.myRoute),
                      ),
                      SizedBox(height: 10),
                      SearchBoxWidget(
                        searchBar:
                            FinishingLocationSearchBar(myRoute: widget.myRoute),
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
                                borderRadius: BorderRadius.circular(20),
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
                            width: 130,
                            key: Key('RiderContainer'),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[200],
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Material(
                              color: Colors.lightBlue[200],
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                splashColor: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(20),
                                onTap: () => {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      backgroundColor: Colors.lightBlue[200],
                                      title: const Text(
                                        'Add riders (Min: 1 | Max: 5)',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      content: new TextField(
                                        controller: riderNumController,
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
                                            updateNumberOfRiders();
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
                                  updateNumberOfRiders(),
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Icon(Icons.person_add,
                                          key: Key('RiderIcon'),
                                          color: Colors.red),
                                    ),
                                    Text(
                                      ':',
                                      key: Key('RiderText'),
                                      style: kSlideUpWidgetLabelTextStyle,
                                    ),
                                    SizedBox(width: 30),
                                    Container(
                                      //padding: EdgeInsets.only(right: 70),
                                      child: Text(
                                        numOfRiders.toString(),
                                        key: Key('RiderValue'),
                                        style: kSlideUpWidgetLabelTextStyle,
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                  ],
                                ),
                              ),
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      );


  Widget buildWidgetGrid() => Center(
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
                    height: 230,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BottomSectionLabel(
                            labelText: 'Bikepoints:',
                            myBikeStationItemWidgetStateRefreshCallback:
                                myBikeStationItemWidgetStateRefresh),
                        SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 0,
                            key: globalBikeStationWidgetItemsKeys.elementAt(0)),
                        SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 1,
                            key: globalBikeStationWidgetItemsKeys.elementAt(1)),
                        SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 2,
                            key: globalBikeStationWidgetItemsKeys.elementAt(2)),
                        SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 3,
                            key: globalBikeStationWidgetItemsKeys.elementAt(3)),
                      ],
                    ),
                  ),
                ),
              ],
            ))),
      );
}

class BikeStationItemWidget extends StatefulWidget {
  BikeStationItemWidget({
    Key? key,
    required this.bikeStationId,
  }) : super(key: key);

  final int bikeStationId;

  @override
  State<BikeStationItemWidget> createState() => _BikeStationItemWidgetState();
}

class _BikeStationItemWidgetState extends State<BikeStationItemWidget> {
  final GlobalKey<_BikeStationDataRowState> _myBikeStationDataRowState =
      GlobalKey<_BikeStationDataRowState>();

  void myBikeStationItemWidgetRefresh() {
    _myBikeStationDataRowState.currentState?._bikeStationDataRowStateRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.lightBlue[200],
          borderRadius: BorderRadius.circular(20.0)),
      child: BikeStationDataRow(
          key: _myBikeStationDataRowState, bikeStationId: widget.bikeStationId),
    );
  }
}

class BikeStationDataRow extends StatefulWidget {
  const BikeStationDataRow({
    Key? key,
    required this.bikeStationId,
  }) : super(key: key);

  final int bikeStationId;

  @override
  State<BikeStationDataRow> createState() =>
      _BikeStationDataRowState(bikeStationId);
}

class _BikeStationDataRowState extends State<BikeStationDataRow> {
  void _bikeStationDataRowStateRefresh() {
    setState(() {
      updateBikeStationPair(this.bikeStationId);
    });
  }

  late final int bikeStationId;
  MapController mapController = MapControllerProvider.mapController;
  Map<String, String> _bikeStationPair = {'loading': '0km'};
  Map<double, double> bikestationCoordinates = {0: 0};

  _BikeStationDataRowState(int bikeStationId) {
    this.bikeStationId = bikeStationId;
    updateBikeStationPair(bikeStationId);
  }

  void updateBikeStationPair(int bikeStationId) {
    BackendService.getNBikeStationForCurrentLocation(bikeStationId).then(
      (incomingBikeStationPair) => setState(() {
        _bikeStationPair = incomingBikeStationPair;
      }),
    );
    BackendService.getNBikeStationForCurrentLocationCoordinates(bikeStationId)
        .then(
      (BikeStationCoordinates) => setState(() {
        bikestationCoordinates = BikeStationCoordinates;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue[200],
      borderRadius: BorderRadius.circular(15.0),
      child: InkWell(
        splashColor: Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          double? lat = bikestationCoordinates.keys.first;
          double? lon = bikestationCoordinates.values.first;
          setState(() {
            mapController.move(LatLng(lat, lon), 18);
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sanitiseString(_bikeStationPair.keys.first, 30),
                style: kSlideUpWidgetRightBottomSectionItemTextStyle,
              ),
              Text(
                _bikeStationPair.values
                    .first, //TODO: implement nearest bikepoints distances
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
  const BottomSectionLabel(
      {Key? key,
      required this.labelText,
      required void myBikeStationItemWidgetStateRefreshCallback()})
      : myBikeStationItemWidgetStateRefreshCallback =
            myBikeStationItemWidgetStateRefreshCallback,
        super(key: key);

  final String labelText;
  final myBikeStationItemWidgetStateRefreshCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            sanitiseString(labelText, 20),
            style: kSlideUpWidgetBottomSectionLabelTextStyle,
          ),
          Material(
            color: Colors.lightBlue[200],
            borderRadius: BorderRadius.circular(15.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.lightBlue,
              onTap: () {
                myBikeStationItemWidgetStateRefreshCallback();
              },
              child: Icon(Icons.refresh),
            ),
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
        const SizedBox(width: 20),
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
        const SizedBox(width: 20),
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
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Stops()),
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
