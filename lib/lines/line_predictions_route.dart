import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'line_predictions_screen.dart';

class LinePredictionsRoute extends GoRouteData {
  const LinePredictionsRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return LinePredictionsScreen(
      id: id,
    );
  }
}
