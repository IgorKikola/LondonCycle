import 'package:cycle/components/menu.dart';
import 'package:cycle/models/named_lat_lng.dart';
import 'package:cycle/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utilities/home_page_design_contants.dart';

/// Navigation page displays a list of all stops in the route selected by the user.
/// The stops already visited are not clickable, the next unvisited stop is clickable,
/// while the rest are highlighted in green.
class NavigationPage extends StatefulWidget {
  static const String id = 'navigation_page';
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int enabledTileIndex = 1;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as NavigationPageArguments;

    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text(
          'Navigation',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.lightBlue,
        child: ListView(
          children: args._stops
              .map(
                (e) => Card(
                  child: ListTile(
                    enabled: args._stops.indexOf(e) == enabledTileIndex,
                    leading: const Icon(
                      Icons.pin_drop_outlined,
                      color: Color.fromRGBO(183, 28, 28, 1),
                    ),
                    title: Text(e.name),

                    tileColor: args._stops.indexOf(e) > enabledTileIndex
                        ? const Color.fromARGB(255, 79, 184, 123)
                        : Colors.lightBlueAccent,
                    // tileColor: Colors.lightBlueAccent,
                    onTap: () async {
                      List<LatLng> stops = [];
                      stops.add(args._stops[args._stops.indexOf(e) - 1]);
                      stops.add(e);

                      Navigation navigation = Navigation(
                          args._context, stops, args._numberOfRiders);
                      await navigation.navigate();

                      setState(() {
                        enabledTileIndex++;
                      });
                      if (enabledTileIndex == args._stops.length) {
                        showAlert(context);
                      }
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

///Arguments of the navigation page that need to be pushed on to the navigator
///along with the page itself for proper functionality.
class NavigationPageArguments {
  final List<NamedLatLng> _stops;
  final dynamic _context;
  final int _numberOfRiders;

  NavigationPageArguments(this._context, this._stops, this._numberOfRiders);
}

Future<void> showAlert(context) async {
  Alert(
    context: context,
    type: AlertType.info,
    title: "HOORAY",
    desc: "You have reached your destination!",
    buttons: [
      DialogButton(
        child: const Text(
          "Continue",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        color: const Color.fromRGBO(0, 179, 134, 1.0),
      ),
    ],
  ).show();
}
