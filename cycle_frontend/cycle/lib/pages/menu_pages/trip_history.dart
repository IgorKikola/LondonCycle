import 'package:flutter/material.dart';
import 'package:cycle/components/menu.dart';

import '../../utilities/constants.dart';

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
        title: Text(
          'Trip History',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
