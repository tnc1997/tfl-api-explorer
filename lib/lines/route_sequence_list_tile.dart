import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'route_sequence_page.dart';

class RouteSequenceListTile extends StatelessWidget {
  const RouteSequenceListTile({
    super.key,
    required this.routeSequence,
  });

  final RouteSequence routeSequence;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        routeSequence.direction ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        routeSequence.orderedLineRoutes?.first.name ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return RouteSequencePage(
                routeSequence: routeSequence,
              );
            },
          ),
        );
      },
    );
  }
}
