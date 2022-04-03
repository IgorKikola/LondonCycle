import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/my_route_provider.dart';
import '../../services/route.dart';
import '../../utilities/home_page_design_contants.dart';

class RidersWidget extends StatefulWidget {
  const RidersWidget({
    Key? key,
  }) : super(key: key);

  @override
  _RidersWidgetWidgetState createState() => _RidersWidgetWidgetState();
}

class _RidersWidgetWidgetState extends State<RidersWidget> {
  final TextEditingController riderNumController = TextEditingController();

  void updateNumberOfRiders() {
    setState(() {
      MyRoute myRoute = MyRouteProvider.myRoute;
      if (int.parse(riderNumController.text) > 5) {
        myRoute.numOfRiders = 5;
      } else if (int.parse(riderNumController.text) > 0) {
        myRoute.numOfRiders = int.parse(riderNumController.text);
      } else {
        myRoute.numOfRiders = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 130,
      key: const Key('RiderContainer'),
      decoration: BoxDecoration(
          color: Colors.lightBlue[200],
          borderRadius: BorderRadius.circular(15.0)),
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          key: const ValueKey('RiderInkwell'),
          splashColor: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
          onTap: () => {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.lightBlue[200],
                title: const Text(
                  'Add riders (Min: 1 | Max: 5)',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                content: TextField(
                  key: const ValueKey('RiderTextField'),
                  controller: riderNumController,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: "Enter the number of riders."),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => {
                      Navigator.pop(context, 'Cancel'),
                      riderNumController.text =
                          MyRouteProvider.myRoute.numOfRiders.toString(),
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                      updateNumberOfRiders();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: Icon(Icons.person_add,
                    key: Key('RiderIcon'), color: Colors.red),
              ),
              const Text(
                ':',
                key: Key('RiderText'),
                style: kSlideUpWidgetLabelTextStyle,
              ),
              const SizedBox(width: 30),
              Text(
                MyRouteProvider.myRoute.numOfRiders.toString(),
                key: const Key('RiderValue'),
                style: kSlideUpWidgetLabelTextStyle,
              ),
              const Flexible(child: SizedBox(width: 50)),
            ],
          ),
        ),
      ),
    );
  }
}
