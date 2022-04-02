import 'package:cycle/components/menu.dart';
import 'package:cycle/utilities/home_page_design_contants.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        title: const Text('Favorites', style: kAppBarTextStyle),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
