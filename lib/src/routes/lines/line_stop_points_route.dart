import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/lines/line_stop_points_page.dart';

class LineStopPointsRoute extends GoRouteData {
  const LineStopPointsRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return LineStopPointsPage(
      id: id,
    );
  }
}
