import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'road_screen.dart';

class RoadRoute extends GoRouteData {
  const RoadRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return RoadScreen(
      id: id,
    );
  }
}
