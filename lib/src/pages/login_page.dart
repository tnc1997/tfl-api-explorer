import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';

  const LoginPage({
    super.key,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _appKeyController;
  late Future<void> _future;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final widget = Padding(
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          LoginForm(
            formKey: _formKey,
            appKeyController: _appKeyController,
            onSubmitted: _login,
          ),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: CircularProgressIndicatorFutureBuilder<void>(
          future: _future,
          builder: (context, preferences) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  return Center(
                    child: SizedBox(
                      width: constraints.maxWidth / 2,
                      child: Card(
                        child: widget,
                      ),
                    ),
                  );
                } else {
                  return widget;
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
    _appKeyController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _appKeyController = TextEditingController();

    _future = SharedPreferencesAsync().getString('appKey').then(
      (appKey) {
        if (appKey != null) {
          _appKeyController.text = appKey;
        }
      },
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authenticationChangeNotifier =
          context.read<AuthenticationChangeNotifier>();

      final navigator = Navigator.of(context);

      final appKey = _appKeyController.text;

      await SharedPreferencesAsync().setString('appKey', appKey);

      authenticationChangeNotifier.login(appKey);

      await navigator.pushReplacementNamed(HomePage.routeName);
    }
  }
}
