// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_parks_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $carParksRoute,
    ];

RouteBase get $carParksRoute => GoRouteData.$route(
      path: '/car-parks',
      factory: $CarParksRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: ':id',
          factory: $CarParkRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'bays',
              factory: $CarParkBaysRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $CarParksRouteExtension on CarParksRoute {
  static CarParksRoute _fromState(GoRouterState state) => const CarParksRoute();

  String get location => GoRouteData.$location(
        '/car-parks',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CarParkRouteExtension on CarParkRoute {
  static CarParkRoute _fromState(GoRouterState state) => CarParkRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/car-parks/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CarParkBaysRouteExtension on CarParkBaysRoute {
  static CarParkBaysRoute _fromState(GoRouterState state) => CarParkBaysRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/car-parks/${Uri.encodeComponent(id)}/bays',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
