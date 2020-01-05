import 'package:flutter/foundation.dart';

class PageNotFoundError extends Error {
  PageNotFoundError({
    @required this.route,
  });

  final String route;

  @override
  String toString() {
    return 'A page matching the route "$route" could not be found.';
  }
}
