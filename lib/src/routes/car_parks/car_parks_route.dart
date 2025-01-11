import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/car_parks/car_parks_page.dart';
import 'car_park_bays_route.dart';
import 'car_park_route.dart';

part 'car_parks_route.g.dart';

@TypedGoRoute<CarParksRoute>(
  path: '/car-parks',
  routes: [
    TypedGoRoute<CarParkRoute>(
      path: ':id',
      routes: [
        TypedGoRoute<CarParkBaysRoute>(
          path: 'bays',
        ),
      ],
    ),
  ],
)
class CarParksRoute extends GoRouteData {
  const CarParksRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const CarParksPage();
  }
}
