import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'errors/page_not_found_error.dart';
import 'material/colors.dart';
import 'notifiers/lines_filter_change_notifier.dart';
import 'notifiers/tfl_api_change_notifier.dart';
import 'pages/home_page.dart';
import 'pages/line_line_disruptions_page.dart';
import 'pages/line_line_routes_page.dart';
import 'pages/line_line_statuses_page.dart';
import 'pages/line_page.dart';
import 'pages/line_predictions_page.dart';
import 'pages/line_route_sequences_page.dart';
import 'pages/line_stop_points_page.dart';
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
      case LineLineDisruptionsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineDisruptionsPage(id: routeSettings.arguments);
          },
        );
      case LineLineRoutesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineRoutesPage(id: routeSettings.arguments);
          },
        );
      case LineLineStatusesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineStatusesPage(id: routeSettings.arguments);
          },
        );
      case LinePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LinePage(id: routeSettings.arguments);
          },
        );
      case LinePredictionsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LinePredictionsPage(id: routeSettings.arguments);
          },
        );
      case LineRouteSequencesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineRouteSequencesPage(id: routeSettings.arguments);
          },
        );
      case LineStopPointsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineStopPointsPage(id: routeSettings.arguments);
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
