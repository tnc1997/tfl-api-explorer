import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/car_parks/car_park_bays_page.dart';

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
    return CarParkBaysPage(
      id: id,
    );
  }
}
