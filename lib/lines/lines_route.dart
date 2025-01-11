import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'line_line_disruptions_route.dart';
import 'line_line_routes_route.dart';
import 'line_line_statuses_route.dart';
import 'line_predictions_route.dart';
import 'line_route.dart';
import 'line_route_sequences_route.dart';
import 'line_stop_points_route.dart';
import 'lines_page.dart';

part 'lines_route.g.dart';

@TypedGoRoute<LinesRoute>(
  path: '/lines',
  routes: [
    TypedGoRoute<LineRoute>(
      path: ':id',
      routes: [
        TypedGoRoute<LineLineDisruptionsRoute>(
          path: 'line-disruptions',
        ),
        TypedGoRoute<LineLineRoutesRoute>(
          path: 'line-routes',
        ),
        TypedGoRoute<LineLineStatusesRoute>(
          path: 'line-statuses',
        ),
        TypedGoRoute<LinePredictionsRoute>(
          path: 'predictions',
        ),
        TypedGoRoute<LineRouteSequencesRoute>(
          path: 'route-sequences',
        ),
        TypedGoRoute<LineStopPointsRoute>(
          path: 'stop-points',
        ),
      ],
    ),
  ],
)
class LinesRoute extends GoRouteData {
  const LinesRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const LinesPage();
  }
}
