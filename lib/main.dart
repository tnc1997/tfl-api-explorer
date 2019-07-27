import 'package:flutter/material.dart';

import 'material/colors.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.route,
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
      supportedLocales: [const Locale('en', 'GB')],
    );
  }

  Route _onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SettingsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return SettingsPage();
          },
        );
      case HomePage.route:
      default:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
    }
  }
}
