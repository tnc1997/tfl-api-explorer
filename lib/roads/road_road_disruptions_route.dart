import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'road_road_disruptions_page.dart';

class RoadRoadDisruptionsRoute extends GoRouteData {
  const RoadRoadDisruptionsRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return RoadRoadDisruptionsPage(
      id: id,
    );
  }
}
