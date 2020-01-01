import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/async.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login';

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _appIdFocus = FocusNode();

  final _appIdKey = GlobalKey<FormFieldState<String>>();

  final _appKeyFocus = FocusNode();

  final _appKeyKey = GlobalKey<FormFieldState<String>>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: CircularProgressIndicatorFutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, data) {
          void login() {
            if (_formKey.currentState.validate()) {
              final appId = _appIdKey.currentState.value;
              final appKey = _appKeyKey.currentState.value;

              data.setString('APP_ID', appId);
              data.setString('APP_KEY', appKey);

              final tflApi = Provider.of<TflApiState>(context, listen: false);
              tflApi.appId = appId;
              tflApi.appKey = appKey;

              Navigator.of(context).pushReplacementNamed(HomePage.route);
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    key: _appIdKey,
                    initialValue: data.getString('APP_ID'),
                    focusNode: _appIdFocus,
                    decoration: InputDecoration(
                      labelText: 'App id',
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      if (_appIdKey.currentState.validate()) {
                        _appIdFocus.unfocus();

                        FocusScope.of(context).requestFocus(_appKeyFocus);
                      }
                    },
                    validator: (value) {
                      return value.isEmpty ? 'Please enter your app id.' : null;
                    },
                  ),
                  TextFormField(
                    key: _appKeyKey,
                    initialValue: data.getString('APP_KEY'),
                    focusNode: _appKeyFocus,
                    decoration: InputDecoration(
                      labelText: 'App key',
                    ),
                    textInputAction: TextInputAction.go,
                    onEditingComplete: () async {
                      if (_appKeyKey.currentState.validate()) {
                        _appKeyFocus.unfocus();

                        login();
                      }
                    },
                    validator: (value) {
                      return value.isEmpty
                          ? 'Please enter your app key.'
                          : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: RaisedButton(
                            onPressed: () async {
                              await launch(
                                'https://api-portal.tfl.gov.uk/signup',
                              );
                            },
                            child: Text('Sign up'),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child: RaisedButton(
                            onPressed: () async {
                              login();
                            },
                            child: Text('Sign in'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
