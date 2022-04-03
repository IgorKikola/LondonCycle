import 'package:flutter/material.dart';

import '../../pages/journey_stop_pages/stored_stops.dart';
import '../../utilities/home_page_design_contants.dart';

class StopsWidget extends StatelessWidget {
  const StopsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Stops()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.add_location_alt, color: Colors.red),
              Text(
                'Stops',
                style: kSlideUpWidgetLabelTextStyle,
              ),
              SizedBox(width: 10.0)
            ],
          ),
        ),
      ),
    );
  }
}
