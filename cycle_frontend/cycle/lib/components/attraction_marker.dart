import 'package:flutter/material.dart';
import 'package:cycle/constants/attraction_constants.dart';

/// Widget of this class represents a marker of a place in the map.
class AttractionMarker extends StatelessWidget {
  final String title;

  const AttractionMarker({required this.title});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      child: const Icon(
        kAttractionMarkerIcon,
        color: Color(kAttractionMarkerColourActive),
      ),
      message: title,
    );
  }
}
