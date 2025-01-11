import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'stop_point_page.dart';

class StopPointRoute extends GoRouteData {
  const StopPointRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return StopPointPage(
      id: id,
    );
  }
}
