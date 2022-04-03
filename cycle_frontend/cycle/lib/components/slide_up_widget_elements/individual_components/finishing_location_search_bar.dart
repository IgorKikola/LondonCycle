import 'package:flutter/material.dart';

import '../../../services/my_route.dart';
import '../../searchbox.dart';

final TextEditingController finishingPointSearchboxTypeAheadController =
    TextEditingController();

class FinishingLocationSearchBar extends StatelessWidget {
  const FinishingLocationSearchBar({
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
          Icons.location_on_outlined,
          color: Colors.red,
        ),
        Flexible(
          child: SearchBox(
            searchboxType: Waypoint.finish,
            myRoute: myRoute,
            typeAheadController: finishingPointSearchboxTypeAheadController,
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
