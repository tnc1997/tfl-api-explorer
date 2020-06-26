import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationChangeNotifier = context.watch<AuthenticationChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('App ID'),
            subtitle: NullableText(authenticationChangeNotifier.appId),
          ),
          ListTile(
            title: Text('App key'),
            subtitle: NullableText(authenticationChangeNotifier.appKey),
          ),
        ],
      ),
    );
  }
}
