// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roads_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $roadsRoute,
    ];

RouteBase get $roadsRoute => GoRouteData.$route(
      path: '/roads',
      factory: $RoadsRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $RoadRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'road-disruptions',
              factory: $RoadRoadDisruptionsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $RoadsRouteExtension on RoadsRoute {
  static RoadsRoute _fromState(GoRouterState state) => const RoadsRoute();

  String get location => GoRouteData.$location(
        '/roads',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RoadRouteExtension on RoadRoute {
  static RoadRoute _fromState(GoRouterState state) => RoadRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/roads/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RoadRoadDisruptionsRouteExtension on RoadRoadDisruptionsRoute {
  static RoadRoadDisruptionsRoute _fromState(GoRouterState state) =>
      RoadRoadDisruptionsRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/roads/${Uri.encodeComponent(id)}/road-disruptions',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
