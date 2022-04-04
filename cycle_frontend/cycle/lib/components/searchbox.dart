import 'package:cycle/models/named_lat_lng.dart';
import 'package:cycle/services/location_manager.dart';
import 'package:cycle/services/mapcontroller_provider.dart';
import 'package:cycle/services/my_route.dart';
import 'package:cycle/services/search_suggestions.dart';
import 'package:cycle/services/stop_location.dart';
import 'package:cycle/utilities/home_page_design_contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../services/marker_location.dart';

const kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  borderSide: BorderSide.none,
);

/// The search widget that allows user to choose a suitable
/// suggestion, based on what is typed into the text field.
class SearchBox extends StatelessWidget {
  final TextEditingController typeAheadController;

  static const int maxLocationStringLength = 30;
  final Waypoint searchboxType;
  final StopLocation stop = StopLocation();
  final MarkerLocation marker = MarkerLocation();
  final MapController mapController = MapControllerProvider.mapController;

  void onSelected(String suggestion) {
    String suggestionFullName = suggestion.toString().split('|').elementAt(0);

    suggestionFullName = sanitiseSearchBoxString(suggestionFullName);

    String longitude = suggestion.toString().split('|').elementAt(2);
    String latitude = suggestion.toString().split('|').elementAt(3);
    double long = double.parse(longitude);
    double lat = double.parse(latitude);
    NamedLatLng selectedLocation =
        NamedLatLng(latitude: lat, longitude: long, name: suggestionFullName);

    updateRouteData(selectedLocation);

    typeAheadController.text = suggestionFullName;
  }

  Future<void> onCurrentLocationClicked() async {
    String suggestionFullName = 'Current location';

    suggestionFullName = sanitiseSearchBoxString(suggestionFullName);

    Position myCurrentPosition = await getPosition();

    double long = myCurrentPosition.longitude;
    double lat = myCurrentPosition.latitude;
    NamedLatLng selectedLocation =
        NamedLatLng(latitude: lat, longitude: long, name: suggestionFullName);

    updateRouteData(selectedLocation);

    typeAheadController.text = suggestionFullName;
  }

  String sanitiseSearchBoxString(String suggestionFullName) {
    if (suggestionFullName.length > maxLocationStringLength) {
      suggestionFullName =
          suggestionFullName.substring(0, maxLocationStringLength) + '...';
    }
    return suggestionFullName;
  }

  void updateRouteData(NamedLatLng selectedLocation) {
    switch (searchboxType) {
      case Waypoint.start:
        myRoute.setStartingLocation(selectedLocation);
        marker.setStartingLocation(selectedLocation);
        mapController.move(
            LatLng(selectedLocation.latitude, selectedLocation.longitude), 16);
        break;
      case Waypoint.finish:
        myRoute.setFinishingLocation(selectedLocation);
        marker.setDestination(selectedLocation);
        mapController.move(
            LatLng(selectedLocation.latitude, selectedLocation.longitude), 16);
        break;
      case Waypoint.midpoint:
        myRoute.addWaypoint(selectedLocation);
        stop.setStopLocation(selectedLocation);
        break;
    }
  }

  final MyRoute myRoute;
  late final String hintText;

  SearchBox({
    Key? key,
    required this.searchboxType,
    required this.myRoute,
    required this.typeAheadController,
  }) : super(key: key) {
    switch (searchboxType) {
      case Waypoint.start:
        hintText = 'Starting location';
        break;
      case Waypoint.finish:
        hintText = 'Destination';
        break;
      case Waypoint.midpoint:
        hintText = 'Enter Stop';
        break;
      default:
        hintText = '';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('Searchbar'),
      height: 30,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlue[200],
          borderRadius: BorderRadius.circular(15.0)),
      // child: Padding(
      // padding: const EdgeInsets.all(10.0),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: typeAheadController,
          // autofocus: true,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.bottom,
          // style: const TextStyle(fontSize: 12.0, color: Colors.black),
          style: kSearchBoxTextStyle,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              alignment: const Alignment(1.0, 0.0),
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.my_location,
                color: Colors.blue,
              ),
              onPressed: onCurrentLocationClicked,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white),
            border: kOutlineInputBorder,
          ),
        ),
        suggestionsCallback: (pattern) =>
            BackendService.getSuggestionsFromGeocoding(pattern),
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.location_on),
            ),
            tileColor: Colors.lightBlueAccent,
            title: Text(
              suggestion.toString().split('|').first,
              style: kSearchBoxSuggestionTitleTextStyle,
            ), //suggestion['name']
            subtitle: Text(
              suggestion.toString().split('|').elementAt(1),
              style: kSearchBoxSuggestionSubtitleTextStyle,
            ),
          );
        },
        onSuggestionSelected: onSelected,
      ),
      // ),
    );
  }
}
