import 'package:flutter/material.dart';

import '../common/drawer.dart';
import 'about_screen.dart';
import 'account_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Account'),
            subtitle: Text('App key'),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AccountScreen();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            subtitle: Text('Package name, version'),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AboutScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }
}
