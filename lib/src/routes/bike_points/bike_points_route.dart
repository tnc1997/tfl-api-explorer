import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/bike_points/bike_points_page.dart';
import 'bike_point_additional_properties_route.dart';
import 'bike_point_route.dart';

part 'bike_points_route.g.dart';

@TypedGoRoute<BikePointsRoute>(
  path: '/bike-points',
  routes: [
    TypedGoRoute<BikePointRoute>(
      path: ':id',
      routes: [
        TypedGoRoute<BikePointAdditionalPropertiesRoute>(
          path: 'additional-properties',
        ),
      ],
    ),
  ],
)
class BikePointsRoute extends GoRouteData {
  const BikePointsRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const BikePointsPage();
  }
}
