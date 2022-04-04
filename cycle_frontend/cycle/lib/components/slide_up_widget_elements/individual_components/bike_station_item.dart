import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../services/mapcontroller_provider.dart';
import '../../../services/search_suggestions.dart';
import '../../../services/string_sanitizer.dart';
import '../../../utilities/home_page_design_contants.dart';

/// Container widget that contains individual bike station information
class BikeStationItemWidget extends StatefulWidget {
  const BikeStationItemWidget({
    Key? key,
    required this.bikeStationId,
  }) : super(key: key);

  final int bikeStationId;

  @override
  State<BikeStationItemWidget> createState() => BikeStationItemWidgetState();
}

class BikeStationItemWidgetState extends State<BikeStationItemWidget> {
  final GlobalKey<_BikeStationDataRowState> _myBikeStationDataRowState =
      GlobalKey<_BikeStationDataRowState>();

  void myBikeStationItemWidgetRefresh() {
    _myBikeStationDataRowState.currentState?._bikeStationDataRowStateRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.lightBlue[200],
          borderRadius: BorderRadius.circular(20.0)),
      child: BikeStationDataRow(
          key: _myBikeStationDataRowState, bikeStationId: widget.bikeStationId),
    );
  }
}

class BikeStationDataRow extends StatefulWidget {
  final int bikeStationId;
  const BikeStationDataRow({
    Key? key,
    required this.bikeStationId,
  }) : super(key: key);

  @override
  State<BikeStationDataRow> createState() => _BikeStationDataRowState();
}

class _BikeStationDataRowState extends State<BikeStationDataRow> {
  late final int bikeStationId;
  void _bikeStationDataRowStateRefresh() {
    setState(() {
      updateBikeStationPair(bikeStationId);
    });
  }

  MapController mapController = MapControllerProvider.mapController;
  Map<String, String> _bikeStationPair = {'loading': '0km'};
  Map<double, double> bikestationCoordinates = {0: 0};

  _BikeStationDataRowState();

  @override
  void initState() {
    super.initState();
    bikeStationId = widget.bikeStationId;
    updateBikeStationPair(bikeStationId);
  }

  void updateBikeStationPair(int bikeStationId) {
    BackendService.getNBikeStationForCurrentLocation(bikeStationId).then(
      (incomingBikeStationPair) => setState(() {
        _bikeStationPair = incomingBikeStationPair;
      }),
    );
    BackendService.getNBikeStationForCurrentLocationCoordinates(bikeStationId)
        .then(
      (coordinates) => setState(() {
        bikestationCoordinates = coordinates;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue[200],
      borderRadius: BorderRadius.circular(15.0),
      child: InkWell(
        splashColor: Colors.lightBlue,
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          double? lat = bikestationCoordinates.keys.first;
          double? lon = bikestationCoordinates.values.first;
          setState(() {
            mapController.move(LatLng(lat, lon), 18);
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringSanitiser.sanitiseString(_bikeStationPair.keys.first, 30),
                style: kSlideUpWidgetRightBottomSectionItemTextStyle,
              ),
              Text(
                _bikeStationPair.values.first,
                style: kSlideUpWidgetRightBottomSectionItemTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
