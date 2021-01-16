import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart' hide Route;
import 'package:tfl_api_explorer/src/colors/tfl_colors.dart';
import 'package:tfl_api_explorer/src/notifiers/authentication_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_points_page.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_park_bays_page.dart';
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
import 'package:tfl_api_explorer/src/pages/road_disruptions/road_disruption_page.dart';
import 'package:tfl_api_explorer/src/pages/roads/road_page.dart';
import 'package:tfl_api_explorer/src/pages/roads/road_road_disruptions_page.dart';
import 'package:tfl_api_explorer/src/pages/roads/roads_page.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_page.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_stop_point_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/settings/settings_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_stop_points_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_lines_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_modes_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_points_page.dart';

Future<void> main() async {
  Intl.defaultLocale = 'en_GB';

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
        ProxyProvider<AuthenticationChangeNotifier, TflApiClient>(
          update: (context, authenticationChangeNotifier, tflApi) {
            return TflApiClient(client: authenticationChangeNotifier.client!);
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
          primaryColor: TflColors.blueGrey[700],
          accentColor: TflColors.blue,
          canvasColor: TflColors.blueGrey[500],
          bottomAppBarColor: TflColors.blueGrey[300],
          cardColor: TflColors.blueGrey[300],
          textSelectionHandleColor: TflColors.blue,
          backgroundColor: TflColors.blueGrey[300],
          dialogBackgroundColor: TflColors.blueGrey[300],
          errorColor: TflColors.red,
          toggleableActiveColor: TflColors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            border: UnderlineInputBorder(),
          ),
        ),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
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
              bikePoint: settings.arguments as Place,
            );
          case BikePointPage.routeName:
            return BikePointPage(
              bikePoint: settings.arguments as Place,
            );
          case BikePointsPage.routeName:
            return BikePointsPage();
          case CarParkBaysPage.routeName:
            return CarParkBaysPage(
              carPark: settings.arguments as Place,
            );
          case CarParkPage.routeName:
            return CarParkPage(
              carPark: settings.arguments as Place,
            );
          case CarParksPage.routeName:
            return CarParksPage();
          case HomePage.routeName:
            return HomePage();
          case LineDisruptionPage.routeName:
            return LineDisruptionPage(
              lineDisruption: settings.arguments as Disruption,
            );
          case LineLineDisruptionsPage.routeName:
            return LineLineDisruptionsPage(
              line: settings.arguments as Line,
            );
          case LineLineRoutesPage.routeName:
            return LineLineRoutesPage(
              line: settings.arguments as Line,
            );
          case LineLineStatusesPage.routeName:
            return LineLineStatusesPage(
              line: settings.arguments as Line,
            );
          case LinePage.routeName:
            return LinePage(
              line: settings.arguments as Line,
            );
          case LinePredictionsPage.routeName:
            return LinePredictionsPage(
              line: settings.arguments as Line,
            );
          case LineRoutePage.routeName:
            return LineRoutePage(
              lineRoute: settings.arguments as MatchedRoute,
            );
          case LineRouteSequencesPage.routeName:
            return LineRouteSequencesPage(
              line: settings.arguments as Line,
            );
          case LineStatusPage.routeName:
            return LineStatusPage(
              lineStatus: settings.arguments as LineStatus,
            );
          case LineStopPointsPage.routeName:
            return LineStopPointsPage(
              line: settings.arguments as Line,
            );
          case LinesPage.routeName:
            return LinesPage();
          case LoginPage.routeName:
            return LoginPage();
          case PredictionPage.routeName:
            return PredictionPage(
              prediction: settings.arguments as Prediction,
            );
          case RoadDisruptionPage.routeName:
            return RoadDisruptionPage(
              roadDisruption: settings.arguments as RoadDisruption,
            );
          case RoadPage.routeName:
            return RoadPage(
              road: settings.arguments as RoadCorridor,
            );
          case RoadRoadDisruptionsPage.routeName:
            return RoadRoadDisruptionsPage(
              road: settings.arguments as RoadCorridor,
            );
          case RoadsPage.routeName:
            return RoadsPage();
          case RouteSequencePage.routeName:
            return RouteSequencePage(
              routeSequence: settings.arguments as RouteSequence,
            );
          case RouteSequenceStopPointSequencesPage.routeName:
            return RouteSequenceStopPointSequencesPage(
              routeSequence: settings.arguments as RouteSequence,
            );
          case SettingsPage.routeName:
            return SettingsPage();
          case StopPointAdditionalPropertiesPage.routeName:
            return StopPointAdditionalPropertiesPage(
              stopPoint: settings.arguments as StopPoint,
            );
          case StopPointLinesPage.routeName:
            return StopPointLinesPage(
              stopPoint: settings.arguments as StopPoint,
            );
          case StopPointModesPage.routeName:
            return StopPointModesPage(
              stopPoint: settings.arguments as StopPoint,
            );
          case StopPointPage.routeName:
            return StopPointPage(
              stopPoint: settings.arguments as StopPoint,
            );
          case StopPointSequencePage.routeName:
            return StopPointSequencePage(
              stopPointSequence: settings.arguments as StopPointSequence,
            );
          case StopPointSequenceStopPointsPage.routeName:
            return StopPointSequenceStopPointsPage(
              stopPointSequence: settings.arguments as StopPointSequence,
            );
          case StopPointsPage.routeName:
            return StopPointsPage();
          default:
            return Scaffold();
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
              'A page matching the route "${settings.name}" could not be found.',
            ),
          ),
        );
      },
      settings: settings,
    );
  }
}
