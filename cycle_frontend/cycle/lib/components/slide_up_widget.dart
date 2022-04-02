import 'package:cycle/components/slide_up_widget_elements/individual_components/bike_station_item.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/bottom_section_label.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/finishing_location_search_bar.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/starting_location_search_bar.dart';
import 'package:cycle/components/slide_up_widget_elements/searchbox_widget.dart';
import 'package:cycle/components/slide_up_widget_elements/stops_widget.dart';
import 'package:cycle/pages/navigation_page.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:cycle/services/routing.dart';
import 'package:cycle/utilities/home_page_design_contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/route.dart';

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
  late List<GlobalKey<BikeStationItemWidgetState>>
      globalBikeStationWidgetItemsKeys =
      _createGlobalBikeStationWidgetItemsKeys(4);

  void myBikeStationItemWidgetStateRefresh() {
    for (GlobalKey<BikeStationItemWidgetState> item
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

  List<GlobalKey<BikeStationItemWidgetState>>
      _createGlobalBikeStationWidgetItemsKeys(int numberOfKeys) {
    List<GlobalKey<BikeStationItemWidgetState>> returnKeys =
        List.empty(growable: true);
    for (int i = 0; i < numberOfKeys; i++) {
      returnKeys.add(_createGlobalKeyForBikeStationWidgetItem());
    }
    return returnKeys;
  }

  GlobalKey<BikeStationItemWidgetState>
      _createGlobalKeyForBikeStationWidgetItem() {
    return GlobalKey<BikeStationItemWidgetState>();
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
          ),
        ),
      );
}
