import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cycle/services/search_suggestions.dart';

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.lightBlueAccent,
  icon: Icon(
    Icons.location_city,
    color: Colors.red,
  ),
  hintText: 'Enter starting point',
  hintStyle: TextStyle(color: Colors.black),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

final TextEditingController _typeAheadController = TextEditingController();

class SearchBox {
  final Widget _searchBox = Padding(
    padding: const EdgeInsets.all(8.0),
    child: TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          autofocus: true,
          style: const TextStyle(fontSize: 12.0, color: Colors.black),
          decoration: kTextFieldInputDecoration),
      suggestionsCallback: (pattern) =>
          BackendService.getSuggestionsFromGeocoding(pattern),
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.location_on),
          ),
          title:
              Text(suggestion.toString().split('|').first), //suggestion['name']
          subtitle: Text(suggestion
              .toString()
              .split('|')
              .elementAt(1)), //'\$${suggestion['price']}'
        );
      },
      onSuggestionSelected: (suggestion) {
        String suggestionFullName =
            suggestion.toString().split('|').elementAt(0) +
                ' - ' +
                suggestion.toString().split('|').elementAt(1);

        String locationCoordinates =
            suggestion.toString().split('|').elementAt(2) +
                ', ' +
                suggestion.toString().split('|').elementAt(3);

        print('picked location coordinates: $locationCoordinates');
        _typeAheadController.text = suggestionFullName;
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ProductPage(product: suggestion)));
      },
    ),
  );

  Widget getSearchBox() {
    return _searchBox;
  }
}
