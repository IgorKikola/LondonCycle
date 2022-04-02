import 'package:flutter/material.dart';
import 'package:cycle/components/menu.dart';

import '../../utilities/home_page_design_contants.dart';

class TripHistory extends StatefulWidget {
  const TripHistory({Key? key}) : super(key: key);

  @override
  _TripHistoryState createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text(
          'Trip History',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
