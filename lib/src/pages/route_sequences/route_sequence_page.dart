import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/material/scroll_view.dart';

class RouteSequencePage extends StatefulWidget {
  static const route = '/route_sequences/:id';

  final RouteSequence routeSequence;

  RouteSequencePage({
    Key key,
    @required this.routeSequence,
  }) : super(key: key);

  @override
  _RouteSequencePageState createState() => _RouteSequencePageState();
}

class _RouteSequencePageState extends State<RouteSequencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routeSequence.direction),
      ),
      body: RouteSequenceListView(
        context: context,
        routeSequence: widget.routeSequence,
      ),
    );
  }
}
