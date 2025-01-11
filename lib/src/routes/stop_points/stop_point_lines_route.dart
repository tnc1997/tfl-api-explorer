import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/stop_points/stop_point_lines_page.dart';

class StopPointLinesRoute extends GoRouteData {
  const StopPointLinesRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return StopPointLinesPage(
      id: id,
    );
  }
}
