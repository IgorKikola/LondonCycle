import 'package:flutter/material.dart';

import '../../../services/my_route.dart';
import '../../searchbox.dart';

final TextEditingController startingPointSearchboxTypeAheadController =
    TextEditingController();

/// Specific searchbar for starting location.
class StartingLocationSearchBar extends StatelessWidget {
  const StartingLocationSearchBar({
    Key? key,
    required this.myRoute,
  }) : super(key: key);

  final MyRoute myRoute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.my_location_rounded,
          color: Colors.red,
        ),
        Flexible(
          child: SearchBox(
            searchboxType: Waypoint.start,
            myRoute: myRoute,
            typeAheadController: startingPointSearchboxTypeAheadController,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
