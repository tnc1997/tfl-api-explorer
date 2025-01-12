import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../home/home_route.dart';
import 'authentication_notifier.dart';
import 'sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
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
          SignInForm(
            formKey: _formKey,
            appKeyController: _appKeyController,
            onSubmitted: _signIn,
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

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      final notifier = context.read<AuthenticationNotifier>();

      final router = GoRouter.of(context);

      final appKey = _appKeyController.text;

      await SharedPreferencesAsync().setString('appKey', appKey);

      notifier.signIn(appKey);

      router.go(const HomeRoute().location);
    }
  }
}
