import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../material/scroll_view.dart';

class LineRoutePage extends StatefulWidget {
  static const route = '/line_routes/:id';

  final LineRoute lineRoute;

  LineRoutePage({
    Key key,
    @required this.lineRoute,
  }) : super(key: key);

  @override
  _LineRoutePageState createState() => _LineRoutePageState();
}

class _LineRoutePageState extends State<LineRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lineRoute.name),
      ),
      body: LineRouteListView(
        context: context,
        lineRoute: widget.lineRoute,
      ),
    );
  }
}
