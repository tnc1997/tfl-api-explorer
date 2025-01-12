import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'car_park_screen.dart';

class CarParkRoute extends GoRouteData {
  const CarParkRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return CarParkScreen(
      id: id,
    );
  }
}
