import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cycle/pages/menu.dart';

class JourneyStops extends StatefulWidget {
  const JourneyStops({Key? key}) : super(key: key);

  @override
  _JourneyStopsState createState() => _JourneyStopsState();
}

class _JourneyStopsState extends State<JourneyStops> {
  final List<String> stops = <String>[];
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Journey Stops',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.lightBlue,
      body: ListView(children: getStops()),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => addStopDialogBox(context),
          tooltip: 'Add Stop',
          child: Icon(Icons.add)),
    );
  }

  void addStop(String location) {
    setState(() {
      stops.add(location);
    });
    textController.clear();
  }

  Widget createStopTile(String location) {
    return Column(children: [
      SizedBox(height: 5),
      Padding(
        padding: EdgeInsets.all(3),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue[200],
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              title: Text(location,
                  style: GoogleFonts.lato(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 18)),
              onLongPress: () {
                // setState(() {
                // stops.removeLast();
                // });
              },
            )),
      ),
      SizedBox(height: 5)
    ]);
  }

  void removeStop(String stop) {
    stops.remove(stop);
  }

  List<Widget> getStops() {
    final List<Widget> stopTiles = <Widget>[];
    for (String stop in stops) {
      stopTiles.add(createStopTile(stop));
    }
    return stopTiles;
  }

  Future<dynamic> addStopDialogBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add a stop',
                style: GoogleFonts.lato(color: Colors.white)),
            backgroundColor: Colors.lightBlue[200],
            content: TextField(
              autofocus: true,
              controller: textController,
              style: GoogleFonts.lato(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Enter Stop',
                  hintStyle: GoogleFonts.lato(color: Colors.white)),
            ),
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
                          Navigator.of(context).pop();
                          addStop(textController.text);
                        }
                      },
                      child: Icon(Icons.add_circle))
                ],
              )
            ],
          );
        });
  }
}
