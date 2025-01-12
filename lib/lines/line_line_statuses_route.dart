import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'line_line_statuses_screen.dart';

class LineLineStatusesRoute extends GoRouteData {
  const LineLineStatusesRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return LineLineStatusesScreen(
      id: id,
    );
  }
}
