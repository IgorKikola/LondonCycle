import 'package:cycle/pages/journey_stop_pages/journey_stops.dart';
import 'package:cycle/services/my_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cycle/services/stops_manager.dart';
import '../../services/route.dart';
import '../../utilities/home_page_design_contants.dart';
import '../../components/menu.dart';

void main() {
  runApp(RemoveStops());
}

class RemoveStops extends StatelessWidget {
  final MyRoute myRoute = MyRouteProvider.myRoute;

  RemoveStops({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StopProvider(),
      child: const Scaffold(
        body: StopTiles(),
      ),
    );
  }
}

class StopTiles extends StatelessWidget {
  const StopTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stopsP = Provider.of<StopProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove Stops', style: kRemoveJourneyStopsTextStyle),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: const Menu(),
      backgroundColor: Colors.lightBlue,
      body: ListView.builder(
        itemCount: stopsP.stops.length,
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
                          stopsP.deleteStop(stopsP.stops[index]);
                        }),
                    title: Text(stopsP.stops[index].name,
                        style: kRemoveJourneyStopsTextStyle),
                  )),
            ),
            const SizedBox(height: 5)
          ]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const JourneyStops(),
              ),
              (route) => route.isFirst);
        },
        child: const Icon(Icons.reset_tv),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
