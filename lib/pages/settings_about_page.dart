import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../widgets/async.dart';
import '../widgets/text.dart';

class SettingsAboutPage extends StatefulWidget {
  SettingsAboutPage({Key key}) : super(key: key);

  @override
  _SettingsAboutPageState createState() => _SettingsAboutPageState();
}

class _SettingsAboutPageState extends State<SettingsAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: CircularProgressIndicatorFutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Package name'),
                subtitle: NullableText(data.packageName),
              ),
              ListTile(
                title: Text('Package version'),
                subtitle: NullableText(data.version),
              ),
            ],
          );
        },
      ),
    );
  }
}
