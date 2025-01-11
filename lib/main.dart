import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'authentication/authentication_notifier.dart';
import 'authentication/sign_in_route.dart';
import 'bike_points/bike_points_route.dart';
import 'car_parks/car_parks_route.dart';
import 'common/colors.dart';
import 'lines/line_filters_notifier.dart';
import 'lines/line_line_route_filters_notifier.dart';
import 'lines/line_prediction_filters_notifier.dart';
import 'lines/lines_route.dart';
import 'roads/roads_route.dart';
import 'settings/settings_route.dart';
import 'src/routes/home_route.dart';
import 'stop_points/stop_point_filters_change_notifier.dart';
import 'stop_points/stop_points_route.dart';

Future<void> main() async {
  Intl.defaultLocale = 'en_GB';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationNotifier>(
          create: (context) {
            return AuthenticationNotifier();
          },
        ),
        ChangeNotifierProvider<LineFiltersNotifier>(
          create: (context) {
            return LineFiltersNotifier();
          },
        ),
        ChangeNotifierProvider<LineLineRouteFiltersNotifier>(
          create: (context) {
            return LineLineRouteFiltersNotifier();
          },
        ),
        ChangeNotifierProvider<LinePredictionFiltersNotifier>(
          create: (context) {
            return LinePredictionFiltersNotifier();
          },
        ),
        ChangeNotifierProvider<StopPointFiltersChangeNotifier>(
          create: (context) {
            return StopPointFiltersChangeNotifier();
          },
        ),
        ProxyProvider<AuthenticationNotifier, TflApiClient>(
          update: (context, notifier, api) {
            return TflApiClient(client: notifier.client!);
          },
        ),
      ],
      child: MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            $homeRoute,
            $bikePointsRoute,
            $carParksRoute,
            $linesRoute,
            $roadsRoute,
            $settingsRoute,
            $signInRoute,
            $stopPointsRoute,
          ],
          redirect: (context, state) {
            if (context.read<AuthenticationNotifier>().client == null) {
              return const SignInRoute().location;
            }

            return null;
          },
        ),
        title: 'Explorer for TfL API',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: TflApiExplorerColors.corporateBlue,
            brightness: Brightness.light,
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: TflApiExplorerColors.corporateBlue,
            brightness: Brightness.dark,
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          ),
        ),
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const <Locale>[
          Locale('en', 'GB'),
        ],
      ),
    );
  }
}
