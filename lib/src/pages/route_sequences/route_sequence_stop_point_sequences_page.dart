import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../widgets/stop_point_sequence_list_tile.dart';

class RouteSequenceStopPointSequencesPage extends StatelessWidget {
  const RouteSequenceStopPointSequencesPage({
    super.key,
    required this.routeSequence,
  });

  final RouteSequence routeSequence;

  @override
  Widget build(BuildContext context) {
    final stopPointSequences = routeSequence.stopPointSequences;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stop point sequences'),
      ),
      body: stopPointSequences != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return StopPointSequenceListTile(
                  stopPointSequence: stopPointSequences[index],
                );
              },
              itemCount: stopPointSequences.length,
            )
          : Container(),
    );
  }
}
