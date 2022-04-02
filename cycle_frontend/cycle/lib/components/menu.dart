import 'package:cycle/pages/menu_pages/favorites.dart';
import 'package:cycle/pages/loading_screens/edit_profile_loading_screen.dart';
import 'package:cycle/pages/loading_screens/view_profile_loading_screen.dart';
import 'package:cycle/pages/menu_pages/settings.dart';
import '../utilities/home_page_design_contants.dart';
import 'package:cycle/pages/menu_pages/trip_history.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.lightBlue,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 30),
          buildMenuText(context),
          const SizedBox(height: 10),
          buildProfile(context),
          const SizedBox(height: 10),
          buildMap(context),
          const SizedBox(height: 10),
          buildFavorites(context),
          const SizedBox(height: 10),
          buildHistory(context),
          const SizedBox(height: 10),
          buildSettings(context),
          const SizedBox(height: 10),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget buildProfile(BuildContext context) => SizedBox(
        height: 50,
        child: Material(
          color: Colors.lightBlue[200],
          borderRadius: BorderRadius.circular(15.0),
          child: InkWell(
            splashColor: Colors.lightBlue,
            child: ListTile(
              leading: const Icon(
                Icons.contacts,
              ),
              title: const Text(
                'My Profile',
                style: kMenuItemTextStyle,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewProfileLoadingScreen()),
                );
              },
            ),
          ),
        ),
      );
}

Widget buildMenuText(BuildContext context) => Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Menu', style: kMenuTextStyle),
          ),
        ),
        const SizedBox(height: 5),
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

Widget buildFavorites(BuildContext context) => SizedBox(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
          child: ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text(
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

Widget buildMap(BuildContext context) => SizedBox(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: const Icon(Icons.map),
            title: const Text(
              'Map',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('home_page'));
            },
          ),
        ),
      ),
    );

Widget buildHistory(BuildContext context) => SizedBox(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: const Icon(Icons.history),
            title: const Text(
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

Widget buildSettings(BuildContext context) => SizedBox(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(
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

Widget buildEditProfile(BuildContext context) => SizedBox(
      height: 50,
      child: Material(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          splashColor: Colors.lightBlue,
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Edit Profile',
              style: kMenuItemTextStyle,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const EditProfileLoadingScreen();
              }));
            },
          ),
        ),
      ),
    );
