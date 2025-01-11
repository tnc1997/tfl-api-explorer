// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lines_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $linesRoute,
    ];

RouteBase get $linesRoute => GoRouteData.$route(
      path: '/lines',
      factory: $LinesRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $LineRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'line-disruptions',
              factory: $LineLineDisruptionsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'line-routes',
              factory: $LineLineRoutesRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'line-statuses',
              factory: $LineLineStatusesRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'predictions',
              factory: $LinePredictionsRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'route-sequences',
              factory: $LineRouteSequencesRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'stop-points',
              factory: $LineStopPointsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $LinesRouteExtension on LinesRoute {
  static LinesRoute _fromState(GoRouterState state) => const LinesRoute();

  String get location => GoRouteData.$location(
        '/lines',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LineRouteExtension on LineRoute {
  static LineRoute _fromState(GoRouterState state) => LineRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/lines/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LineLineDisruptionsRouteExtension on LineLineDisruptionsRoute {
  static LineLineDisruptionsRoute _fromState(GoRouterState state) =>
      LineLineDisruptionsRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/lines/${Uri.encodeComponent(id)}/line-disruptions',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LineLineRoutesRouteExtension on LineLineRoutesRoute {
  static LineLineRoutesRoute _fromState(GoRouterState state) =>
      LineLineRoutesRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/lines/${Uri.encodeComponent(id)}/line-routes',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LineLineStatusesRouteExtension on LineLineStatusesRoute {
  static LineLineStatusesRoute _fromState(GoRouterState state) =>
      LineLineStatusesRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/lines/${Uri.encodeComponent(id)}/line-statuses',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LinePredictionsRouteExtension on LinePredictionsRoute {
  static LinePredictionsRoute _fromState(GoRouterState state) =>
      LinePredictionsRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/lines/${Uri.encodeComponent(id)}/predictions',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LineRouteSequencesRouteExtension on LineRouteSequencesRoute {
  static LineRouteSequencesRoute _fromState(GoRouterState state) =>
      LineRouteSequencesRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/lines/${Uri.encodeComponent(id)}/route-sequences',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LineStopPointsRouteExtension on LineStopPointsRoute {
  static LineStopPointsRoute _fromState(GoRouterState state) =>
      LineStopPointsRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/lines/${Uri.encodeComponent(id)}/stop-points',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
