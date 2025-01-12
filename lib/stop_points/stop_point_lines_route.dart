import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'stop_point_lines_screen.dart';

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
    return StopPointLinesScreen(
      id: id,
    );
  }
}
