import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/stop_points/stop_points_page.dart';
import 'stop_point_additional_properties_route.dart';
import 'stop_point_lines_route.dart';
import 'stop_point_modes_route.dart';
import 'stop_point_route.dart';

part 'stop_points_route.g.dart';

@TypedGoRoute<StopPointsRoute>(
  path: '/stop-points',
  routes: [
    TypedGoRoute<StopPointRoute>(
      path: ':id',
      routes: [
        TypedGoRoute<StopPointAdditionalPropertiesRoute>(
          path: 'additional-properties',
        ),
        TypedGoRoute<StopPointLinesRoute>(
          path: 'lines',
        ),
        TypedGoRoute<StopPointModesRoute>(
          path: 'modes',
        ),
      ],
    ),
  ],
)
class StopPointsRoute extends GoRouteData {
  const StopPointsRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const StopPointsPage();
  }
}
