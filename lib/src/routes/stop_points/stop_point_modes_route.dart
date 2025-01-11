import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/stop_points/stop_point_modes_page.dart';

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
    return StopPointModesPage(
      id: id,
    );
  }
}
