import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cycle/models/stop.dart';
import 'package:cycle/components/searchbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/my_route_provider.dart';
import '../../services/route.dart';
import '../../services/stop_location.dart';
import '../../utilities/constants.dart';


class Stops extends StatefulWidget {
  const Stops({Key? key}) : super(key: key);

  @override
  _StopsState createState() => _StopsState();
}

class _StopsState extends State<Stops> {
  @override
  void initState() {
    super.initState();
    serializeStops();
  }

  late SharedPreferences prefs;
  List stopObjects = [];
  MyRoute myRoute = MyRouteProvider.myRoute;
  final TextEditingController textController = TextEditingController();
  StopLocation stopCoordinates = StopLocation();

  serializeStops() async {
    prefs = await SharedPreferences.getInstance();
    String? localStops = prefs.getString('stop');
    List stops = jsonDecode(localStops!);
    for (var stop in stops) {
      int index = 0;
      setState(() {
        stopObjects.add(Stop(index + 1, localStops, 0, 0).fromJson(stop));
      });
    }
  }

  void addStop() {
    List storedStops = stopObjects.map((x) => x.toJson()).toList();
    prefs.setString('stop', jsonEncode(storedStops));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: const Text("Stops", style: kJourneyStopsTextStyle),
          backgroundColor: Colors.lightBlue,
        ),
      ),
      backgroundColor: Colors.lightBlue,
      body: ListView.builder(
          itemCount: stopObjects.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[200],
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            MyRouteProvider.myRoute.removeWaypointAt(index);
                            setState(() {
                              stopObjects.remove(stopObjects[index]);
                            });
                            addStop();
                          }),
                      title: Text(
                        stopObjects[index].name,
                        style: kJourneyStopsTileTextStyle,
                      ),
                    )),
              ),
              const SizedBox(height: 5),
            ]);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: "deleteALl",
              backgroundColor: Colors.red,
              onPressed: () {
                setState(() {
                  MyRouteProvider.myRoute.waypoints.clear();
                  stopObjects.clear();
                  addStop();
                });
              },
              child: const Icon(Icons.delete_forever_outlined, color: Colors.black),
            ),
            FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.lightBlue[200],
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Add a stop',
                            style: kJourneyStopsTextStyle),
                        backgroundColor: Colors.lightBlue[200],
                        content: SearchBox(
                            searchboxType: Waypoint.MIDPOINT,
                            myRoute: myRoute,
                            typeAheadController: textController),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                  ),
                                  onPressed: () {
                                    if (textController.text.isNotEmpty) {
                                      setState(() {
                                        int index = 0;
                                        double stopLat = stopCoordinates
                                            .getStopLocation()
                                            .latitude;
                                        double stopLon = stopCoordinates
                                            .getStopLocation()
                                            .longitude;
                                        final Stop newStop = Stop(
                                            index + 1,
                                            textController.text,
                                            stopLat,
                                            stopLon);
                                        textController.clear();
                                        stopObjects.add(newStop);
                                      });
                                      addStop();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: const Icon(Icons.add_circle))
                            ],
                          )
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
