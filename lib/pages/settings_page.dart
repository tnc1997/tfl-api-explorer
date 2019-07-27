import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../widgets/async.dart';
import '../widgets/drawer.dart';
import 'settings_about_page.dart';
import 'settings_authentication_page.dart';

class SettingsPage extends StatefulWidget {
  static const route = '/settings';

  SettingsPage({Key key}) : super(key: key);

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
      body: CircularProgressIndicatorFutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.security),
                title: Text('Authentication'),
                subtitle: Text('App id, app key'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingsAuthenticationPage();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                subtitle: Text('Package name, package version'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingsAboutPage();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
