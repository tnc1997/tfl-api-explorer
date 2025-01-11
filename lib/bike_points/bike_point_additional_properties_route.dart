import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bike_point_additional_properties_page.dart';

class BikePointAdditionalPropertiesRoute extends GoRouteData {
  const BikePointAdditionalPropertiesRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return BikePointAdditionalPropertiesPage(
      id: id,
    );
  }
}
