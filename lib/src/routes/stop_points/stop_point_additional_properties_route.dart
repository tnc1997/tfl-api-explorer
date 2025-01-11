import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/stop_points/stop_point_additional_properties_page.dart';

class StopPointAdditionalPropertiesRoute extends GoRouteData {
  const StopPointAdditionalPropertiesRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return StopPointAdditionalPropertiesPage(
      id: id,
    );
  }
}
