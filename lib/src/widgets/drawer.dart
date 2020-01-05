import 'package:flutter/material.dart' as material;
import 'package:tfl_api_explorer/src/material/colors.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/lines_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/settings_page.dart';

class Drawer extends material.StatelessWidget {
  Drawer({
    material.Key key,
  }) : super(
          key: key,
        );

  @override
  material.Widget build(material.BuildContext context) {
    return material.Drawer(
      child: material.ListView(
        padding: material.EdgeInsets.zero,
        children: [
          material.DrawerHeader(
            decoration: material.BoxDecoration(
              color: TflColors.blue,
            ),
            child: material.Text('TfL API Explorer'),
          ),
          material.ListTile(
            leading: material.Icon(material.Icons.home),
            title: material.Text('Home'),
            onTap: () {
              material.Navigator.of(context).pushReplacementNamed(
                HomePage.route,
              );
            },
          ),
          material.ListTile(
            leading: material.Icon(material.Icons.http),
            title: material.Text('Bike points'),
            onTap: () {
              material.Navigator.of(context).pushReplacementNamed(
                BikePointsPage.route,
              );
            },
          ),
          material.ListTile(
            leading: material.Icon(material.Icons.http),
            title: material.Text('Lines'),
            onTap: () {
              material.Navigator.of(context).pushReplacementNamed(
                LinesPage.route,
              );
            },
          ),
          material.ListTile(
            leading: material.Icon(material.Icons.settings),
            title: material.Text('Settings'),
            onTap: () {
              material.Navigator.of(context).pushReplacementNamed(
                SettingsPage.route,
              );
            },
          ),
        ],
      ),
    );
  }
}
