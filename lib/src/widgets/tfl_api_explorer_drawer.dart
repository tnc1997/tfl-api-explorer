import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_parks_page.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/lines_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/settings_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_points_page.dart';

class TflApiExplorerDrawer extends StatelessWidget {
  TflApiExplorerDrawer({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text('TfL API Explorer'),
          ),
          ListTile(
            leading: Icon(Mdi.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                HomePage.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Mdi.api),
            title: Text('Bike points'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                BikePointsPage.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Mdi.api),
            title: Text('Car parks'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                CarParksPage.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Mdi.api),
            title: Text('Lines'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                LinesPage.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Mdi.api),
            title: Text('Stop points'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                StopPointsPage.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Mdi.cog),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                SettingsPage.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}
