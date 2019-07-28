import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'errors/page_not_found_error.dart';
import 'material/colors.dart';
import 'notifiers/lines_filter_change_notifier.dart';
import 'notifiers/tfl_api_change_notifier.dart';
import 'pages/home_page.dart';
import 'pages/lines_page.dart';
import 'pages/login_page.dart';
import 'pages/settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(
          builder: (context) {
            return TflApiChangeNotifier();
          },
        ),
        ChangeNotifierProvider(
          builder: (context) {
            return LinesFilterChangeNotifier();
          },
        ),
      ],
      child: MaterialApp(
        home: LoginPage(),
        onGenerateRoute: _onGenerateRoute,
        title: 'TfL API Explorer',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: TflColors.corporateBlue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: TflColors.corporateBlue,
        ),
        supportedLocales: const <Locale>[Locale('en', 'GB')],
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
      case LinesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LinesPage();
          },
        );
      case LoginPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        );
      case SettingsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return SettingsPage();
          },
        );
      default:
        throw PageNotFoundError(routeSettings.name);
    }
  }
}
