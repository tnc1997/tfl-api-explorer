import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'car_park_bays_screen.dart';

class CarParkBaysRoute extends GoRouteData {
  const CarParkBaysRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return CarParkBaysScreen(
      id: id,
    );
  }
}
