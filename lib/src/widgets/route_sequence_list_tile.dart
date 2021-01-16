import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_page.dart';

class RouteSequenceListTile extends StatelessWidget {
  RouteSequenceListTile({
    Key? key,
    required this.routeSequence,
  }) : super(
          key: key,
        );

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
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteSequencePage.routeName,
          arguments: routeSequence,
        );
      },
    );
  }
}
