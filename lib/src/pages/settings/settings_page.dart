import 'package:flutter/material.dart';
import 'package:tfl_api_explorer/src/pages/settings/about_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/account_page.dart';
import 'package:tfl_api_explorer/src/widgets/drawer.dart' as drawer;

class SettingsPage extends StatefulWidget {
  static const route = '/settings';

  SettingsPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            subtitle: Text('App id, app key'),
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
      drawer: drawer.Drawer(),
    );
  }
}
