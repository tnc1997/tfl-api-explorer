import 'package:flutter/material.dart';

import '../models/drawer_item.dart';
import '../pages/home_page.dart';
import '../pages/settings_page.dart';

class AppDrawer extends Drawer {
  static final List<DrawerItem> _drawerItems = [
    DrawerItem(
      title: 'Home',
      icon: Icon(Icons.home),
      route: HomePage.route,
    ),
    DrawerItem(
      title: 'Settings',
      icon: Icon(Icons.settings),
      route: SettingsPage.route,
    ),
  ];

  AppDrawer({Key key})
      : super(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: _drawerItems[index].icon,
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    _drawerItems[index].route,
                  );
                },
                title: Text(_drawerItems[index].title),
              );
            },
            itemCount: _drawerItems.length,
          ),
          key: key,
        );
}
