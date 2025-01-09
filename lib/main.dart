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
import 'src/pages/bike_points/bike_point_additional_properties_page.dart';
import 'src/pages/bike_points/bike_point_page.dart';
import 'src/pages/bike_points/bike_points_page.dart';
import 'src/pages/car_parks/car_park_bays_page.dart';
import 'src/pages/car_parks/car_park_page.dart';
import 'src/pages/car_parks/car_parks_page.dart';
import 'src/pages/home_page.dart';
import 'src/pages/lines/line_line_disruptions_page.dart';
import 'src/pages/lines/line_line_routes_page.dart';
import 'src/pages/lines/line_line_statuses_page.dart';
import 'src/pages/lines/line_page.dart';
import 'src/pages/lines/line_predictions_page.dart';
import 'src/pages/lines/line_route_sequences_page.dart';
import 'src/pages/lines/line_stop_points_page.dart';
import 'src/pages/lines/lines_page.dart';
import 'src/pages/login_page.dart';
import 'src/pages/roads/road_page.dart';
import 'src/pages/roads/road_road_disruptions_page.dart';
import 'src/pages/roads/roads_page.dart';
import 'src/pages/settings/settings_page.dart';
import 'src/pages/stop_points/stop_point_additional_properties_page.dart';
import 'src/pages/stop_points/stop_point_lines_page.dart';
import 'src/pages/stop_points/stop_point_modes_page.dart';
import 'src/pages/stop_points/stop_point_page.dart';
import 'src/pages/stop_points/stop_points_page.dart';

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
            GoRoute(
              path: '/',
              builder: (context, state) {
                return HomePage();
              },
            ),
            GoRoute(
              path: '/bike_points',
              builder: (context, state) {
                return BikePointsPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    return BikePointPage(
                      id: state.pathParameters['id']!,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'additional_properties',
                      builder: (context, state) {
                        return BikePointAdditionalPropertiesPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/car_parks',
              builder: (context, state) {
                return CarParksPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    return CarParkPage(
                      id: state.pathParameters['id']!,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'bays',
                      builder: (context, state) {
                        return CarParkBaysPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/lines',
              builder: (context, state) {
                return LinesPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    return LinePage(
                      id: state.pathParameters['id']!,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'line_disruptions',
                      builder: (context, state) {
                        return LineLineDisruptionsPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'line_routes',
                      builder: (context, state) {
                        return LineLineRoutesPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'line_statuses',
                      builder: (context, state) {
                        return LineLineStatusesPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'predictions',
                      builder: (context, state) {
                        return LinePredictionsPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'route_sequences',
                      builder: (context, state) {
                        return LineRouteSequencesPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                    GoRoute(
                      path: 'stop_points',
                      builder: (context, state) {
                        return LineStopPointsPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) {
                return LoginPage();
              },
            ),
            GoRoute(
              path: '/roads',
              builder: (context, state) {
                return RoadsPage();
              },
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) {
                    return RoadPage(
                      id: state.pathParameters['id']!,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: 'road_disruptions',
                      builder: (context, state) {
                        return RoadRoadDisruptionsPage(
                          id: state.pathParameters['id']!,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) {
                return SettingsPage();
              },
            ),
            GoRoute(
              path: '/stop_points',
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
                      path: 'additional_properties',
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
            if (context.read<AuthenticationChangeNotifier>().client != null) {
              return null;
            } else {
              return '/login';
            }
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
