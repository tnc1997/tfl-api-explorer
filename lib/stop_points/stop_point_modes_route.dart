import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'stop_point_modes_screen.dart';

class StopPointModesRoute extends GoRouteData {
  const StopPointModesRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return StopPointModesScreen(
      id: id,
    );
  }
}
