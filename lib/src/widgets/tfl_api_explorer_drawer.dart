import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/bike_points/bike_points_route.dart';
import '../routes/home_route.dart';

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
              context.go('/car-parks');
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Lines'),
            onTap: () {
              context.go('/lines');
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Roads'),
            onTap: () {
              context.go('/roads');
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Stop points'),
            onTap: () {
              context.go('/stop-points');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              context.go('/settings');
            },
          ),
        ],
      ),
    );
  }
}
