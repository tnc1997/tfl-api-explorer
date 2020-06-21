import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _appIdController;
  TextEditingController _appKeyController;
  Future<SharedPreferences> _preferencesFuture;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CircularProgressIndicatorFutureBuilder<SharedPreferences>(
          future: _preferencesFuture,
          builder: (context, preferences) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  return Center(
                    child: SizedBox(
                      width: constraints.maxWidth / 2,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 16.0,
                                ),
                                child: Text(
                                  'Sign in',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              LoginForm(
                                formKey: _formKey,
                                appIdController: _appIdController,
                                appKeyController: _appKeyController,
                                onSubmitted: _login,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            bottom: 16.0,
                          ),
                          child: Text(
                            'Sign in',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        LoginForm(
                          formKey: _formKey,
                          appIdController: _appIdController,
                          appKeyController: _appKeyController,
                          onSubmitted: _login,
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _appIdController.dispose();
    _appKeyController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _appIdController = TextEditingController();
    _appKeyController = TextEditingController();

    _preferencesFuture = SharedPreferences.getInstance().then((preferences) {
      if (preferences.containsKey('APP_ID')) {
        _appIdController.text = preferences.getString('APP_ID');
      }

      if (preferences.containsKey('APP_KEY')) {
        _appKeyController.text = preferences.getString('APP_KEY');
      }

      return preferences;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState.validate()) {
      final preferences = await SharedPreferences.getInstance();

      final appId = _appIdController.text;
      final appKey = _appKeyController.text;

      await preferences.setString('APP_ID', appId);
      await preferences.setString('APP_KEY', appKey);

      context.read<AuthenticationChangeNotifier>().login(appId, appKey);

      await Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
  }
}
