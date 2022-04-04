import 'package:cycle/services/string_sanitizer.dart';
import 'package:flutter/material.dart';

import '../../../utilities/home_page_design_contants.dart';

/// Description for the bottom part of the slide up widget.
class BottomSectionLabel extends StatelessWidget {
  const BottomSectionLabel(
      {Key? key,
      required this.labelText,
      required Function this.myBikeStationItemWidgetStateRefreshCallback})
      : super(key: key);

  final String labelText;
  final dynamic myBikeStationItemWidgetStateRefreshCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringSanitiser.sanitiseString(labelText, 20),
            style: kSlideUpWidgetBottomSectionLabelTextStyle,
          ),
          Material(
            color: Colors.lightBlue[200],
            borderRadius: BorderRadius.circular(15.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.lightBlue,
              onTap: () {
                myBikeStationItemWidgetStateRefreshCallback();
              },
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}
