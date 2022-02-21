import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cycle/pages/menu.dart';

class JourneyStops extends StatefulWidget {
  const JourneyStops({Key? key}) : super(key: key);

  @override
  _JourneyStopsState createState() => _JourneyStopsState();
}

class _JourneyStopsState extends State<JourneyStops> {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {addStops();},
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [SizedBox(height: 10),
            createStop("Strand Campus"),
            createStop("Waterloo Campus"),
            createStop("Guy's Campus"),
            createStop("King's College London")
          ],
        ),
      ),
    );
  }

  Widget createStop(String stop) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue[200],
                borderRadius: BorderRadius.circular(10.0)),
            padding: EdgeInsets.all(5.0),
            child: ListTile(
                title: Text("$stop",
                    style: GoogleFonts.lato(
                        fontStyle: FontStyle.normal, color: Colors.white)),
                onLongPress: () {}),
          ),
        ),
      ],
    );
  }

  void addStops() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.lightBlue[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            "Add Stop", style: GoogleFonts.lato(
              fontStyle: FontStyle.normal, color: Colors.white)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  autofocus: true,
                  style: GoogleFonts.lato(
                  fontStyle: FontStyle.normal, color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: (){},

                      child: Icon(Icons.add_circle))
                ],
              )
            ],
          ),
        ),
    );
  }
}
