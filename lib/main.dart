import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/src/errors/page_not_found_error.dart';
import 'package:tfl_api_explorer/src/material/colors.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/line_disruptions/line_disruption_page.dart';
import 'package:tfl_api_explorer/src/pages/line_routes/line_route_page.dart';
import 'package:tfl_api_explorer/src/pages/line_statuses/line_status_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_disruptions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_routes_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_statuses_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_predictions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_route_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_stop_points_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/lines_page.dart';
import 'package:tfl_api_explorer/src/pages/predictions/prediction_page.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_page.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_stop_point_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/settings_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_stop_points_page.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
import 'package:tfl_api_explorer/src/pages/login_page.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';

Future<void> main() async {
  await _configureIntl();

  runApp(MyApp());
}

Future<void> _configureIntl() async {
  Intl.defaultLocale = 'en_GB';

  await initializeDateFormatting('en_GB');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return LineFiltersChangeNotifier();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LineLineRouteFiltersChangeNotifier();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LinePredictionFiltersChangeNotifier();
          },
        ),
        Provider(
          create: (context) {
            return TflApiState();
          },
        ),
      ],
      child: MaterialApp(
        home: LoginPage(),
        onGenerateRoute: _onGenerateRoute,
        title: 'TfL API Explorer',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: TflColors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: TflColors.blue,
        ),
        supportedLocales: const <Locale>[Locale('en', 'GB')],
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case BikePointAdditionalPropertiesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return BikePointAdditionalPropertiesPage(
              bikePoint: routeSettings.arguments,
            );
          },
        );
      case BikePointPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return BikePointPage(bikePoint: routeSettings.arguments);
          },
        );
      case BikePointsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return BikePointsPage();
          },
        );
      case HomePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
      case LineDisruptionPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineDisruptionPage(lineDisruption: routeSettings.arguments);
          },
        );
      case LineLineDisruptionsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineDisruptionsPage(line: routeSettings.arguments);
          },
        );
      case LineLineRoutesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineRoutesPage(line: routeSettings.arguments);
          },
        );
      case LineLineStatusesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineStatusesPage(line: routeSettings.arguments);
          },
        );
      case LinePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LinePage(line: routeSettings.arguments);
          },
        );
      case LinePredictionsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LinePredictionsPage(line: routeSettings.arguments);
          },
        );
      case LineRoutePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineRoutePage(lineRoute: routeSettings.arguments);
          },
        );
      case LineRouteSequencesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineRouteSequencesPage(line: routeSettings.arguments);
          },
        );
      case LineStatusPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineStatusPage(lineStatus: routeSettings.arguments);
          },
        );
      case LineStopPointsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return LineStopPointsPage(line: routeSettings.arguments);
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
      case PredictionPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return PredictionPage(prediction: routeSettings.arguments);
          },
        );
      case RouteSequencePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return RouteSequencePage(routeSequence: routeSettings.arguments);
          },
        );
      case RouteSequenceStopPointSequencesPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return RouteSequenceStopPointSequencesPage(
              routeSequence: routeSettings.arguments,
            );
          },
        );
      case SettingsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return SettingsPage();
          },
        );
      case StopPointPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointPage(
              stopPoint: routeSettings.arguments,
            );
          },
        );
      case StopPointSequencePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointSequencePage(
              stopPointSequence: routeSettings.arguments,
            );
          },
        );
      case StopPointSequenceStopPointsPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointSequenceStopPointsPage(
              stopPointSequence: routeSettings.arguments,
            );
          },
        );
      default:
        throw PageNotFoundError(
          route: routeSettings.name,
        );
    }
  }
}
