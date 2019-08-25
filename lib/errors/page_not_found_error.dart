class PageNotFoundError extends Error {
  final String route;

  PageNotFoundError(this.route);

  @override
  String toString() {
    return 'A page matching the route "$route" could not be found.';
  }
}
