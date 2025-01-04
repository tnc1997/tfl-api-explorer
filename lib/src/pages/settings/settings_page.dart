import 'package:flutter/material.dart';
import 'package:tfl_api_explorer/src/pages/settings/about_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/account_page.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';

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
