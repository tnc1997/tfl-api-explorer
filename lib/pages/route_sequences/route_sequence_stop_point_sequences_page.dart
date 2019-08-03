import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';

class RouteSequenceStopPointSequencesPage extends StatefulWidget {
  static const route = '/route_sequences/:id/stop_point_sequences';

  final RouteSequence routeSequence;

  RouteSequenceStopPointSequencesPage({
    Key key,
    @required this.routeSequence,
  }) : super(key: key);

  @override
  _RouteSequenceStopPointSequencesPageState createState() =>
      _RouteSequenceStopPointSequencesPageState();
}

class _RouteSequenceStopPointSequencesPageState
    extends State<RouteSequenceStopPointSequencesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop point sequences'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return StopPointSequenceListTile(
            context: context,
            stopPointSequence: widget.routeSequence.stopPointSequences[index],
          );
        },
        itemCount: widget.routeSequence.stopPointSequences.length,
      ),
    );
  }
}
