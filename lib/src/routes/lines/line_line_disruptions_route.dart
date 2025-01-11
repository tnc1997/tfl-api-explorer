import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/lines/line_line_disruptions_page.dart';

class LineLineDisruptionsRoute extends GoRouteData {
  const LineLineDisruptionsRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return LineLineDisruptionsPage(
      id: id,
    );
  }
}
