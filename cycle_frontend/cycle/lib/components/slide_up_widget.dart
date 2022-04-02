import 'package:cycle/components/searchbox.dart';
import 'package:cycle/pages/navigation_page.dart';
import 'package:cycle/services/routing.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:cycle/services/search_suggestions.dart';
import 'package:cycle/utilities/home_page_design_contants.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/journey_stop_pages/stored_stops.dart';
import '../services/mapcontroller_provider.dart';
import '../services/route.dart';
import 'package:cycle/pages/journey_stop_pages/stored_stops.dart';
import 'package:flutter_map/flutter_map.dart';

final TextEditingController startingPointSearchboxTypeAheadController =
    TextEditingController();
final TextEditingController finishingPointSearchboxTypeAheadController =
    TextEditingController();

class SlideUpWidget extends StatefulWidget {
  final ScrollController controller;
  final dynamic mapRefreshCallback;
  final MyRoute myRoute = MyRouteProvider.myRoute;

  SlideUpWidget(
      {Key? key,
      required this.controller,
      required void this.mapRefreshCallback()})
      : super(key: key);

  @override
  _SlideUpWidgetState createState() => _SlideUpWidgetState();
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
    await RoutingService.updateCoordinatesForRoute(widget.myRoute);

    widget.mapRefreshCallback();
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          buildSlidingHandle(),
          const SizedBox(height: 10),
          buildSearchBar(context),
          const SizedBox(height: 5),
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
              padding: const EdgeInsets.all(1),
              child: Container(
                padding: const EdgeInsets.all(15.0),
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
                      const SizedBox(height: 10),
                      SearchBoxWidget(
                        searchBar:
                            FinishingLocationSearchBar(myRoute: widget.myRoute),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(child: StopsWidget()),
                          const SizedBox(width: 10),
                          Container(
                            height: 30,
                            width: 30,
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
                                  children: const [
                                    Icon(Icons.search, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3.0),
                          Container(
                            height: 30,
                            width: 30,
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
                                  if (isRouteComplete()) {
                                    Navigator.pushNamed(
                                      context,
                                      NavigationPage.id,
                                      arguments: NavigationPageArguments(
                                          context,
                                          widget.myRoute.getRouteAsList(),
                                          // .map((coordinate) => LatLng(
                                          //     coordinate.latitude,
                                          //     coordinate.longitude))
                                          // .toList(),
                                          numOfRiders),
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.navigation, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Container(
                              height: 30,
                              width: 130,
                              key: const Key('RiderContainer'),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue[200],
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Material(
                                color: Colors.lightBlue[200],
                                borderRadius: BorderRadius.circular(15.0),
                                child: InkWell(
                                  key: const ValueKey('RiderInkwell'),
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
                                        content: TextField(
                                          key: const ValueKey('RiderTextField'),
                                          controller: riderNumController,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: const InputDecoration(
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
                                              labelText:
                                                  "Enter the number of riders."),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
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
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Icon(Icons.person_add,
                                            key: Key('RiderIcon'),
                                            color: Colors.red),
                                      ),
                                      const Text(
                                        ':',
                                        key: Key('RiderText'),
                                        style: kSlideUpWidgetLabelTextStyle,
                                      ),
                                      const SizedBox(width: 30),
                                      Text(
                                        numOfRiders.toString(),
                                        key: const Key('RiderValue'),
                                        style: kSlideUpWidgetLabelTextStyle,
                                      ),
                                      const Flexible(
                                          child: SizedBox(width: 50)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
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
                        const SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 0,
                            key: globalBikeStationWidgetItemsKeys.elementAt(0)),
                        const SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 1,
                            key: globalBikeStationWidgetItemsKeys.elementAt(1)),
                        const SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 2,
                            key: globalBikeStationWidgetItemsKeys.elementAt(2)),
                        const SizedBox(height: 10),
                        BikeStationItemWidget(
                            bikeStationId: 3,
                            key: globalBikeStationWidgetItemsKeys.elementAt(3)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      );
}

class BikeStationItemWidget extends StatefulWidget {
  const BikeStationItemWidget({
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
  final int bikeStationId;
  const BikeStationDataRow({
    Key? key,
    required this.bikeStationId,
  }) : super(key: key);

  @override
  State<BikeStationDataRow> createState() => _BikeStationDataRowState();
}

class _BikeStationDataRowState extends State<BikeStationDataRow> {
  late final int bikeStationId;
  void _bikeStationDataRowStateRefresh() {
    setState(() {
      updateBikeStationPair(bikeStationId);
    });
  }

  MapController mapController = MapControllerProvider.mapController;
  Map<String, String> _bikeStationPair = {'loading': '0km'};
  Map<double, double> bikestationCoordinates = {0: 0};

  _BikeStationDataRowState();

  @override
  void initState() {
    super.initState();
    bikeStationId = widget.bikeStationId;
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
      (coordinates) => setState(() {
        bikestationCoordinates = coordinates;
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
                _bikeStationPair.values.first,
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
      required Function this.myBikeStationItemWidgetStateRefreshCallback})
      : super(key: key);

  final String labelText;
  final dynamic myBikeStationItemWidgetStateRefreshCallback;

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
              child: const Icon(Icons.refresh),
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
        const Icon(
          Icons.my_location_rounded,
          color: Colors.red,
        ),
        Flexible(
          child: SearchBox(
            searchboxType: Waypoint.start,
            myRoute: myRoute,
            typeAheadController: startingPointSearchboxTypeAheadController,
          ),
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
        const Icon(
          Icons.location_on_outlined,
          color: Colors.red,
        ),
        Flexible(
          child: SearchBox(
            searchboxType: Waypoint.finish,
            myRoute: myRoute,
            typeAheadController: finishingPointSearchboxTypeAheadController,
          ),
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
              MaterialPageRoute(builder: (context) => const Stops()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
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

String sanitiseString(String string, int maxLength) =>
    string.length >= maxLength
        ? string.substring(0, maxLength - 1) + '...'
        : string;
