import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bike_point_screen.dart';

class BikePointRoute extends GoRouteData {
  const BikePointRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return BikePointScreen(
      id: id,
    );
  }
}
