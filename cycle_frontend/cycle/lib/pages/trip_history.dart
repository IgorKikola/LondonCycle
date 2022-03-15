import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cycle/pages/menu.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  _TripHistoryState createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        title: Text('Trip History',
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.lightBlue,
      ),

    );
  }
}
