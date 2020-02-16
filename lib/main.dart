import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/errors/page_not_found_error.dart';
import 'package:tfl_api_explorer/src/material/colors.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/home_page.dart';
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
import 'package:tfl_api_explorer/src/pages/login_page.dart';
import 'package:tfl_api_explorer/src/pages/predictions/prediction_page.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_page.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_stop_point_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/settings_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_lines_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_modes_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_stop_points_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_points_page.dart';

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
        ChangeNotifierProvider<AuthenticationChangeNotifier>(
          create: (context) {
            return AuthenticationChangeNotifier();
          },
        ),
        ChangeNotifierProvider<LineFiltersChangeNotifier>(
          create: (context) {
            return LineFiltersChangeNotifier();
          },
        ),
        ChangeNotifierProvider<LineLineRouteFiltersChangeNotifier>(
          create: (context) {
            return LineLineRouteFiltersChangeNotifier();
          },
        ),
        ChangeNotifierProvider<LinePredictionFiltersChangeNotifier>(
          create: (context) {
            return LinePredictionFiltersChangeNotifier();
          },
        ),
        ChangeNotifierProvider<StopPointFiltersChangeNotifier>(
          create: (context) {
            return StopPointFiltersChangeNotifier();
          },
        ),
        ProxyProvider<AuthenticationChangeNotifier, TflApi>(
          update: (context, authenticationChangeNotifier, tflApi) {
            return TflApi(authenticationChangeNotifier.client);
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
          accentColor: TflColors.blue,
          toggleableActiveColor: TflColors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: TflColors.blue,
          accentColor: TflColors.blue,
          toggleableActiveColor: TflColors.blue,
        ),
        supportedLocales: const <Locale>[Locale('en', 'GB')],
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case BikePointAdditionalPropertiesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BikePointAdditionalPropertiesPage(
              bikePoint: routeSettings.arguments,
            );
          },
        );
      case BikePointPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BikePointPage(bikePoint: routeSettings.arguments);
          },
        );
      case BikePointsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BikePointsPage();
          },
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );
      case LineDisruptionPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LineDisruptionPage(lineDisruption: routeSettings.arguments);
          },
        );
      case LineLineDisruptionsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineDisruptionsPage(line: routeSettings.arguments);
          },
        );
      case LineLineRoutesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineRoutesPage(line: routeSettings.arguments);
          },
        );
      case LineLineStatusesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LineLineStatusesPage(line: routeSettings.arguments);
          },
        );
      case LinePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LinePage(line: routeSettings.arguments);
          },
        );
      case LinePredictionsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LinePredictionsPage(line: routeSettings.arguments);
          },
        );
      case LineRoutePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LineRoutePage(lineRoute: routeSettings.arguments);
          },
        );
      case LineRouteSequencesPage.routeName:
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
      case LineStopPointsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LineStopPointsPage(line: routeSettings.arguments);
          },
        );
      case LinesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LinesPage();
          },
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        );
      case PredictionPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return PredictionPage(prediction: routeSettings.arguments);
          },
        );
      case RouteSequencePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return RouteSequencePage(routeSequence: routeSettings.arguments);
          },
        );
      case RouteSequenceStopPointSequencesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return RouteSequenceStopPointSequencesPage(
              routeSequence: routeSettings.arguments,
            );
          },
        );
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SettingsPage();
          },
        );
      case StopPointAdditionalPropertiesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointAdditionalPropertiesPage(
              stopPoint: routeSettings.arguments,
            );
          },
        );
      case StopPointLinesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointLinesPage(
              stopPoint: routeSettings.arguments,
            );
          },
        );
      case StopPointModesPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointModesPage(
              stopPoint: routeSettings.arguments,
            );
          },
        );
      case StopPointPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointPage(
              stopPoint: routeSettings.arguments,
            );
          },
        );
      case StopPointSequencePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointSequencePage(
              stopPointSequence: routeSettings.arguments,
            );
          },
        );
      case StopPointSequenceStopPointsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointSequenceStopPointsPage(
              stopPointSequence: routeSettings.arguments,
            );
          },
        );
      case StopPointsPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return StopPointsPage();
          },
        );
      default:
        throw PageNotFoundError(
          route: routeSettings.name,
        );
    }
  }
}
