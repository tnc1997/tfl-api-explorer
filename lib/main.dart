import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'src/colors/tfl_colors.dart';
import 'src/notifiers/authentication_change_notifier.dart';
import 'src/notifiers/line_filters_change_notifier.dart';
import 'src/notifiers/line_line_route_filters_change_notifier.dart';
import 'src/notifiers/line_prediction_filters_change_notifier.dart';
import 'src/notifiers/stop_point_filters_change_notifier.dart';
import 'src/pages/settings/settings_page.dart';
import 'src/pages/stop_points/stop_point_additional_properties_page.dart';
import 'src/pages/stop_points/stop_point_lines_page.dart';
import 'src/pages/stop_points/stop_point_modes_page.dart';
import 'src/pages/stop_points/stop_point_page.dart';
import 'src/pages/stop_points/stop_points_page.dart';
import 'src/routes/bike_points/bike_points_route.dart';
import 'src/routes/car_parks/car_parks_route.dart';
import 'src/routes/home_route.dart';
import 'src/routes/lines/lines_route.dart';
import 'src/routes/roads/roads_route.dart';
import 'src/routes/sign_in_route.dart';

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
      child: MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            $homeRoute,
            $bikePointsRoute,
            $carParksRoute,
            $linesRoute,
            $roadsRoute,
            GoRoute(
              path: '/settings',
              builder: (context, state) {
                return SettingsPage();
              },
            ),
            $signInRoute,
            GoRoute(
              path: '/stop-points',
              builder: (context, state) {
                return StopPointsPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    return StopPointPage(
                      id: state.pathParameters['id']!,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'additional-properties',
                      builder: (context, state) {
                        return StopPointAdditionalPropertiesPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'lines',
                      builder: (context, state) {
                        return StopPointLinesPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'modes',
                      builder: (context, state) {
                        return StopPointModesPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
          redirect: (context, state) {
            if (context.read<AuthenticationChangeNotifier>().client == null) {
              return const SignInRoute().location;
            }

            return null;
          },
        ),
        title: 'Explorer for TfL API',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: TflColors.corporateBlue,
            brightness: Brightness.light,
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: TflColors.corporateBlue,
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
