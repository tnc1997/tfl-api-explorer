// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_points_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $stopPointsRoute,
    ];

RouteBase get $stopPointsRoute => GoRouteData.$route(
      path: '/stop-points',
      factory: $StopPointsRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $StopPointRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'additional-properties',
              factory: $StopPointAdditionalPropertiesRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'lines',
              factory: $StopPointLinesRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'modes',
              factory: $StopPointModesRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $StopPointsRouteExtension on StopPointsRoute {
  static StopPointsRoute _fromState(GoRouterState state) =>
      const StopPointsRoute();

  String get location => GoRouteData.$location(
        '/stop-points',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StopPointRouteExtension on StopPointRoute {
  static StopPointRoute _fromState(GoRouterState state) => StopPointRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/stop-points/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StopPointAdditionalPropertiesRouteExtension
    on StopPointAdditionalPropertiesRoute {
  static StopPointAdditionalPropertiesRoute _fromState(GoRouterState state) =>
      StopPointAdditionalPropertiesRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/stop-points/${Uri.encodeComponent(id)}/additional-properties',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StopPointLinesRouteExtension on StopPointLinesRoute {
  static StopPointLinesRoute _fromState(GoRouterState state) =>
      StopPointLinesRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/stop-points/${Uri.encodeComponent(id)}/lines',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StopPointModesRouteExtension on StopPointModesRoute {
  static StopPointModesRoute _fromState(GoRouterState state) =>
      StopPointModesRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/stop-points/${Uri.encodeComponent(id)}/modes',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
