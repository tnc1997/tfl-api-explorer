import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'stop_point_sequence_stop_points_screen.dart';

class StopPointSequenceScreen extends StatelessWidget {
  const StopPointSequenceScreen({
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
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return StopPointSequenceStopPointsScreen(
                      stopPointSequence: stopPointSequence,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
