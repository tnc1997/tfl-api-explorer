import 'package:flutter/material.dart';

import '../../bike_points/bike_points_route.dart';
import '../routes/car_parks/car_parks_route.dart';
import '../routes/home_route.dart';
import '../routes/lines/lines_route.dart';
import '../routes/roads/roads_route.dart';
import '../routes/settings/settings_route.dart';
import '../routes/stop_points/stop_points_route.dart';

class TflApiExplorerDrawer extends StatelessWidget {
  const TflApiExplorerDrawer({
    super.key,
  });

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
            child: Text(
              'Explorer for TfL API',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              const HomeRoute().go(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Bike points'),
            onTap: () {
              const BikePointsRoute().go(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Car parks'),
            onTap: () {
              const CarParksRoute().go(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Lines'),
            onTap: () {
              const LinesRoute().go(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Roads'),
            onTap: () {
              const RoadsRoute().go(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Stop points'),
            onTap: () {
              const StopPointsRoute().go(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              const SettingsRoute().go(context);
            },
          ),
        ],
      ),
    );
  }
}
