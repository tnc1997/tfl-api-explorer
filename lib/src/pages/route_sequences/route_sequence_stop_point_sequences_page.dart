import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_sequence_list_tile.dart';

class RouteSequenceStopPointSequencesPage extends StatelessWidget {
  static const routeName = '/route_sequences/:id/stop_point_sequences';

  RouteSequenceStopPointSequencesPage({
    Key key,
    @required this.routeSequence,
  }) : super(
          key: key,
        );

  final RouteSequence routeSequence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop point sequences'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return StopPointSequenceListTile(
            stopPointSequence: routeSequence.stopPointSequences[index],
          );
        },
        itemCount: routeSequence.stopPointSequences.length,
      ),
    );
  }
}
