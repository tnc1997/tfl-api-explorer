import 'package:flutter/material.dart';

import '../../widgets/tfl_api_explorer_drawer.dart';
import 'about_page.dart';
import 'account_page.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AccountPage();
                  },
                ),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            subtitle: Text('Package name, version'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AboutPage();
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
