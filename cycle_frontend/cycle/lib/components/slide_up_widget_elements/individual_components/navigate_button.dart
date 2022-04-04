import 'package:flutter/material.dart';

import '../../../pages/navigation_page.dart';
import '../../../services/my_route_provider.dart';

/// Button to take user to navigation page.
class NavigateButton extends StatelessWidget {
  const NavigateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(15.0)),
      child: Material(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (MyRouteProvider.myRoute.isRouteComplete()) {
              Navigator.pushNamed(
                context,
                NavigationPage.id,
                arguments: NavigationPageArguments(
                    context,
                    MyRouteProvider.myRoute.getRouteAsList(),
                    MyRouteProvider.myRoute.numOfRiders),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.navigation, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
