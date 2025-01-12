import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'sign_in_screen.dart';

part 'sign_in_route.g.dart';

@TypedGoRoute<SignInRoute>(
  path: '/signin',
)
class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) {
    return const SignInScreen();
  }
}
