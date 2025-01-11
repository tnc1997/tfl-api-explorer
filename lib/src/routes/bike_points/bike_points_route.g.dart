// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike_points_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $bikePointsRoute,
    ];

RouteBase get $bikePointsRoute => GoRouteData.$route(
      path: '/bike-points',
      factory: $BikePointsRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $BikePointRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'additional-properties',
              factory: $BikePointAdditionalPropertiesRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $BikePointsRouteExtension on BikePointsRoute {
  static BikePointsRoute _fromState(GoRouterState state) =>
      const BikePointsRoute();

  String get location => GoRouteData.$location(
        '/bike-points',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BikePointRouteExtension on BikePointRoute {
  static BikePointRoute _fromState(GoRouterState state) => BikePointRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/bike-points/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BikePointAdditionalPropertiesRouteExtension
    on BikePointAdditionalPropertiesRoute {
  static BikePointAdditionalPropertiesRoute _fromState(GoRouterState state) =>
      BikePointAdditionalPropertiesRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/bike-points/${Uri.encodeComponent(id)}/additional-properties',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
