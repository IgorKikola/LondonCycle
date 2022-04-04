import 'package:flutter/material.dart';

/// Container for the search bar.
class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key? key,
    required this.searchBar,
  }) : super(key: key);

  final Widget searchBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: searchBar,
    );
  }
}
