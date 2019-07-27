import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../widgets/async.dart';
import '../widgets/drawer.dart';

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
                title: Text('Package name'),
                subtitle: Text(data.packageName),
              ),
              ListTile(
                title: Text('Package version'),
                subtitle: Text(data.version),
              ),
            ],
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
