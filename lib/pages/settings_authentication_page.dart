import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/async.dart';

class SettingsAuthenticationPage extends StatefulWidget {
  static const route = '/settings';

  SettingsAuthenticationPage({Key key}) : super(key: key);

  @override
  _SettingsAuthenticationPageState createState() =>
      _SettingsAuthenticationPageState();
}

class _SettingsAuthenticationPageState
    extends State<SettingsAuthenticationPage> {
  final _appIdFocus = FocusNode();

  final _appIdKey = GlobalKey<FormFieldState<String>>();

  final _appKeyFocus = FocusNode();

  final _appKeyKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: () async {
              await launch('https://api-portal.tfl.gov.uk/admin/applications');
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, data) {
          return Column(
            children: <Widget>[
              Form(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        key: _appIdKey,
                        initialValue: data.getString('APP_ID') ?? '',
                        focusNode: _appIdFocus,
                        decoration: InputDecoration(
                          labelText: 'App ID',
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          if (_appIdKey.currentState.validate()) {
                            _appIdFocus.unfocus();

                            FocusScope.of(context).requestFocus(_appKeyFocus);
                          }
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Please enter your app id.'
                              : null;
                        },
                      ),
                      TextFormField(
                        key: _appKeyKey,
                        initialValue: data.getString('APP_KEY') ?? '',
                        focusNode: _appKeyFocus,
                        decoration: InputDecoration(
                          labelText: 'App Key',
                        ),
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          if (_appKeyKey.currentState.validate()) {
                            _appKeyFocus.unfocus();

                            data.setString(
                              'APP_ID',
                              _appIdKey.currentState.value,
                            );
                            data.setString(
                              'APP_KEY',
                              _appKeyKey.currentState.value,
                            );

                            Navigator.pop(context);
                          }
                        },
                        validator: (value) {
                          return value.isEmpty
                              ? 'Please enter your app key.'
                              : null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
