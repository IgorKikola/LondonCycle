import 'package:cycle/components/slide_up_widget_elements/individual_components/bike_station_item.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/bottom_section_label.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/finishing_location_search_bar.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/navigate_button.dart';
import 'package:cycle/components/slide_up_widget_elements/individual_components/starting_location_search_bar.dart';
import 'package:cycle/components/slide_up_widget_elements/riders_widget.dart';
import 'package:cycle/components/slide_up_widget_elements/searchbox_widget.dart';
import 'package:cycle/components/slide_up_widget_elements/stops_widget.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:cycle/services/routing.dart';
import 'package:flutter/material.dart';

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
                          buildFindRouteButton(),
                          const SizedBox(width: 3.0),
                          const NavigateButton(),
                          const SizedBox(width: 10),
                          const Flexible(child: RidersWidget()),
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

  Container buildFindRouteButton() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(15.0)),
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
    );
  }

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
