import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../widgets/async.dart';
import '../../widgets/drawer.dart';
import 'about_page.dart';
import 'account_page.dart';
import 'filters_page.dart';

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
                title: Text('Filters'),
                subtitle: Text('Lines'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FiltersPage();
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
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
