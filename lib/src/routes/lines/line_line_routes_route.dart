import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/lines/line_line_routes_page.dart';

class LineLineRoutesRoute extends GoRouteData {
  const LineLineRoutesRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return LineLineRoutesPage(
      id: id,
    );
  }
}
