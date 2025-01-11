import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/roads/roads_page.dart';
import 'road_road_disruptions_route.dart';
import 'road_route.dart';

part 'roads_route.g.dart';

@TypedGoRoute<RoadsRoute>(
  path: '/roads',
  routes: [
    TypedGoRoute<RoadRoute>(
      path: ':id',
      routes: [
        TypedGoRoute<RoadRoadDisruptionsRoute>(
          path: 'road-disruptions',
        ),
      ],
    ),
  ],
)
class RoadsRoute extends GoRouteData {
  const RoadsRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const RoadsPage();
  }
}
