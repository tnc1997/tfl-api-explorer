import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/authentication_notifier.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<AuthenticationNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('App key'),
            subtitle: Text(notifier.appKey ?? 'Unknown'),
          ),
        ],
      ),
    );
  }
}
