import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/colors/tfl_colors.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_park_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_park_page.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_parks_page.dart';
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
  Intl.defaultLocale = 'en_GB';

  await initializeDateFormatting();

  runApp(MyApp());
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
        initialRoute: LoginPage.routeName,
        onGenerateRoute: _onGenerateRoute,
        onUnknownRoute: _onUnknownRoute,
        title: 'TfL API Explorer',
        theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: TflColors.blue,
          errorColor: TflColors.red,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            border: UnderlineInputBorder(),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: TflColors.blue,
          primaryColor: TflColors.blueGrey,
          accentColor: TflColors.blue,
          canvasColor: TflColors.blueGrey,
          bottomAppBarColor: TflColors.blueGrey,
          cardColor: TflColors.blueGrey,
          textSelectionHandleColor: TflColors.blue,
          errorColor: TflColors.red,
          toggleableActiveColor: TflColors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            border: UnderlineInputBorder(),
          ),
        ),
//        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const <Locale>[
          Locale('en', 'GB'),
        ],
      ),
    );
  }

  Route<T> _onGenerateRoute<T>(RouteSettings settings) {
    return MaterialPageRoute<T>(
      builder: (context) {
        switch (settings.name) {
          case BikePointAdditionalPropertiesPage.routeName:
            return BikePointAdditionalPropertiesPage(
              bikePoint: settings.arguments,
            );
          case BikePointPage.routeName:
            return BikePointPage(
              bikePoint: settings.arguments,
            );
          case BikePointsPage.routeName:
            return BikePointsPage();
          case CarParkAdditionalPropertiesPage.routeName:
            return CarParkAdditionalPropertiesPage(
              carPark: settings.arguments,
            );
          case CarParkPage.routeName:
            return CarParkPage(
              carPark: settings.arguments,
            );
          case CarParksPage.routeName:
            return CarParksPage();
          case HomePage.routeName:
            return HomePage();
          case LineDisruptionPage.routeName:
            return LineDisruptionPage(
              lineDisruption: settings.arguments,
            );
          case LineLineDisruptionsPage.routeName:
            return LineLineDisruptionsPage(
              line: settings.arguments,
            );
          case LineLineRoutesPage.routeName:
            return LineLineRoutesPage(
              line: settings.arguments,
            );
          case LineLineStatusesPage.routeName:
            return LineLineStatusesPage(
              line: settings.arguments,
            );
          case LinePage.routeName:
            return LinePage(
              line: settings.arguments,
            );
          case LinePredictionsPage.routeName:
            return LinePredictionsPage(
              line: settings.arguments,
            );
          case LineRoutePage.routeName:
            return LineRoutePage(
              lineRoute: settings.arguments,
            );
          case LineRouteSequencesPage.routeName:
            return LineRouteSequencesPage(
              line: settings.arguments,
            );
          case LineStatusPage.routeName:
            return LineStatusPage(
              lineStatus: settings.arguments,
            );
          case LineStopPointsPage.routeName:
            return LineStopPointsPage(
              line: settings.arguments,
            );
          case LinesPage.routeName:
            return LinesPage();
          case LoginPage.routeName:
            return LoginPage();
          case PredictionPage.routeName:
            return PredictionPage(
              prediction: settings.arguments,
            );
          case RouteSequencePage.routeName:
            return RouteSequencePage(
              routeSequence: settings.arguments,
            );
          case RouteSequenceStopPointSequencesPage.routeName:
            return RouteSequenceStopPointSequencesPage(
              routeSequence: settings.arguments,
            );
          case SettingsPage.routeName:
            return SettingsPage();
          case StopPointAdditionalPropertiesPage.routeName:
            return StopPointAdditionalPropertiesPage(
              stopPoint: settings.arguments,
            );
          case StopPointLinesPage.routeName:
            return StopPointLinesPage(
              stopPoint: settings.arguments,
            );
          case StopPointModesPage.routeName:
            return StopPointModesPage(
              stopPoint: settings.arguments,
            );
          case StopPointPage.routeName:
            return StopPointPage(
              stopPoint: settings.arguments,
            );
          case StopPointSequencePage.routeName:
            return StopPointSequencePage(
              stopPointSequence: settings.arguments,
            );
          case StopPointSequenceStopPointsPage.routeName:
            return StopPointSequenceStopPointsPage(
              stopPointSequence: settings.arguments,
            );
          case StopPointsPage.routeName:
            return StopPointsPage();
          default:
            return null;
        }
      },
      settings: settings,
    );
  }

  Route<T> _onUnknownRoute<T>(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Text(
                'A page matching the route "${settings.name}" could not be found.'),
          ),
        );
      },
      settings: settings,
    );
  }
}
