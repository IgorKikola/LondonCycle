import 'package:cycle/pages/favorites.dart';
import 'package:cycle/pages/home_page.dart';
import 'package:cycle/pages/loading_screens/edit_profile_loading_screen.dart';
import 'package:cycle/pages/settings.dart';
import 'package:cycle/pages/starting_page.dart';
import 'package:cycle/pages/trip_history.dart';
import 'package:cycle/services/user_details_helper.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'profile.dart';
import 'trip_history.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          SizedBox(height: 30),
          buildMenuText(context),
          SizedBox(height: 10),
          buildProfile(context),
          SizedBox(height: 10),
          buildMap(context),
          SizedBox(height: 10),
          buildFavorites(context),
          SizedBox(height: 10),
          buildHistory(context),
          SizedBox(height: 10),
          buildSettings(context),
          SizedBox(height: 50),
          // EDIT THIS PART ACCORDING TO YOUR DESIGN
          buildEditProfile(context),

          ElevatedButton(
            onPressed: () {
              UserDetailsHelper.logout(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, StartingPage.id, (route) => false);
            },
            child: const Text('Log out'),
          )
        ],
      ),
    );
  }
}

Widget buildProfile(BuildContext context) => Container(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: Icon(
              Icons.contacts,
            ),
            title: Text(
              'My Profile',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
        ),
      ),
    );

Widget buildMenuText(BuildContext context) => Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: const Text('Menu', style: kMenuTextStyle),
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 260,
          height: 1,
          decoration: BoxDecoration(
            color: Colors.lightBlue[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ],
    );

Widget buildFavorites(BuildContext context) => Container(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
          child: ListTile(
            key: Key('FavoritesTab'),
            leading: Icon(Icons.favorite),
            title: Text(
              'Favorites',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Favorites()),
              );
            },
          ),
        ),
      ),
    );

Widget buildMap(BuildContext context) => Container(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: Icon(Icons.map),
            title: Text(
              'Map',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
      ),
    );

Widget buildHistory(BuildContext context) => Container(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: Icon(Icons.history),
            title: Text(
              'Trip History',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TripHistory()),
              );
            },
          ),
        ),
      ),
    );

Widget buildSettings(BuildContext context) => Container(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ),
      ),
    );

Widget buildEditProfile(BuildContext context) => Container(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Edit Profile',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditProfileLoadingScreen();
              }));
            },
          ),
        ),
      ),
    );
