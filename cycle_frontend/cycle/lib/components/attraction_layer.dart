import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

/// A layer which contains Map markers.
class AttractionLayer extends StatefulWidget {
  final List<Marker> markers;

  const AttractionLayer({Key? key, required this.markers}) : super(key: key);

  @override
  _AttractionLayerState createState() => _AttractionLayerState();
}

class _AttractionLayerState extends State<AttractionLayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayerWidget(
      options: MarkerLayerOptions(
        markers: widget.markers,
      ),
    );
  }
}
