import 'package:cycle/services/my_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:cycle/pages/menu.dart';
import 'package:cycle/models/stop.dart';
import 'package:cycle/pages/journey_stop_pages/remove_stops.dart';
import 'package:cycle/services/stop_location.dart';
import 'package:provider/provider.dart';
import 'package:cycle/services/stops_manager.dart';
import 'package:cycle/components/searchbox.dart';
import '../../services/route.dart';
import '../../utilities/constants.dart';
import '../home_page.dart';
import '../menu.dart';

void main() {
  runApp( JourneyStops());
}
class JourneyStops extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StopProvider(),
      child: Scaffold(
        body: StopTiles(),
      ),
    );
  }
}

class StopTiles extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  StopLocation stopCoordinates = StopLocation();
  MyRoute myRoute = MyRouteProvider.myRoute;

  @override
  Widget build(BuildContext context) {
    final allStops = Provider.of<StopProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Journey Stops', style: kJourneyStopsTextStyle) ,
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.lightBlue,
      drawer: Menu(),
      body: ListView.builder(
        itemCount: allStops.stops.length,
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
                    title: Text(
                        allStops.stops[index].name,
                        style: kJourneyStopsTileTextStyle,
                    ),
                  )),
            ),
            const SizedBox(height: 5),
          ]);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "Remove",
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RemoveStops()),
                );
              },
              child: Icon(Icons.delete),
            ),
            Container(
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
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(),), (route) => route.isFirst);
                  },
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(width: 10.0),
                      Text('Return to Map',
                          style: kJourneyStopsTextStyle),
                      SizedBox(width: 10.0)
                    ],
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: "Create",
              backgroundColor: Colors.lightBlue[200],
              onPressed: () {showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Add a stop',
                          style: kJourneyStopsTextStyle),
                      backgroundColor: Colors.lightBlue[200],
                      content: SearchBox(
                          searchboxType: Waypoint.MIDPOINT,
                          myRoute: myRoute,
                          typeAheadController:
                          textController),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                                ),
                                onPressed: () {
                                  if (textController.text.isEmpty == false) {
                                    int index = 0;
                                    double stopLat = stopCoordinates.getStopLocation().latitude;
                                    double stopLon = stopCoordinates.getStopLocation().longitude;
                                    final JourneyStop newStop = JourneyStop(name: textController.text, lat: stopLat, lon: stopLon, id: index + 1);
                                    textController.clear();
                                    allStops.addStop(newStop);
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
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}