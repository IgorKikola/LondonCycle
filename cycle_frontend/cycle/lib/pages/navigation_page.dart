import 'package:cycle/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utilities/constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:cycle/components/menu.dart';

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
      drawer: Menu(),
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
                    title: Text('Stop ${args._stops.indexOf(e)}'),
                    tileColor: Colors.lightBlueAccent,
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

class NavigationPageArguments {
  final List<LatLng> _stops;
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
