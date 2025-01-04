import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_stop_points_page.dart';

class StopPointSequencePage extends StatelessWidget {
  static const routeName = '/stop_point_sequences/:id';

  StopPointSequencePage({
    super.key,
    required this.stopPointSequence,
  });

  final StopPointSequence stopPointSequence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stopPointSequence.branchId.toString()),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Line name'),
            subtitle: Text(
              stopPointSequence.lineName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Service type'),
            subtitle: Text(
              stopPointSequence.serviceType ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Stop points'),
            onTap: () {
              Navigator.of(context).pushNamed(
                StopPointSequenceStopPointsPage.routeName,
                arguments: stopPointSequence,
              );
            },
          ),
        ],
      ),
    );
  }
}
