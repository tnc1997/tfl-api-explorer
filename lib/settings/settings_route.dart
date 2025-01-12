import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'settings_screen.dart';

part 'settings_route.g.dart';

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const SettingsScreen();
  }
}
