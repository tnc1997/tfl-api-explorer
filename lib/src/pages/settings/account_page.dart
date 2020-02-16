import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Consumer<AuthenticationChangeNotifier>(
        builder: (context, authenticationChangeNotifier, child) {
          return ListView(
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
          );
        },
      ),
    );
  }
}
