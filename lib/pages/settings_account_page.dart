import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/tfl_api_change_notifier.dart';
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
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('App id'),
                subtitle: NullableText(tflApi.appId),
              ),
              ListTile(
                title: Text('App key'),
                subtitle: NullableText(tflApi.appKey),
              ),
            ],
          );
        },
      ),
    );
  }
}
