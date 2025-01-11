import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'line_page.dart';

class LineRoute extends GoRouteData {
  const LineRoute({
    required this.id,
  });

  final String id;

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return LinePage(
      id: id,
    );
  }
}
