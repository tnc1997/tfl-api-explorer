import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/lines/line_route_sequences_page.dart';

class LineRouteSequencesRoute extends GoRouteData {
  const LineRouteSequencesRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return LineRouteSequencesPage(
      id: id,
    );
  }
}
