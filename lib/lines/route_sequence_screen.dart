import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'route_sequence_stop_point_sequences_screen.dart';

class RouteSequenceScreen extends StatelessWidget {
  const RouteSequenceScreen({
    super.key,
    required this.routeSequence,
  });

  final RouteSequence routeSequence;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeSequence.direction ?? 'Unknown'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Line name'),
            subtitle: Text(
              routeSequence.lineName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Mode'),
            subtitle: Text(
              routeSequence.mode ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Stop point sequences'),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return RouteSequenceStopPointSequencesScreen(
                      routeSequence: routeSequence,
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
