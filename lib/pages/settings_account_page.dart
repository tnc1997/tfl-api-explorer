import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/async.dart';
import '../widgets/text.dart';

class SettingsAccountPage extends StatefulWidget {
  SettingsAccountPage({Key key}) : super(key: key);

  @override
  _SettingsAccountPageState createState() => _SettingsAccountPageState();
}

class _SettingsAccountPageState extends State<SettingsAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: CircularProgressIndicatorFutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('App id'),
                subtitle: NullableText(data.getString('APP_ID')),
              ),
              ListTile(
                title: Text('App key'),
                subtitle: NullableText(data.getString('APP_KEY')),
              ),
            ],
          );
        },
      ),
    );
  }
}
