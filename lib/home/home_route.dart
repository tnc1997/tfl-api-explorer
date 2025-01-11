import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const HomePage();
  }
}
