import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_stop_point_sequences_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class RouteSequencePage extends StatelessWidget {
  static const routeName = '/route_sequences/:id';

  RouteSequencePage({
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
        title: Text(routeSequence.direction),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Line name'),
            subtitle: NullableText(
              routeSequence.lineName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Mode'),
            subtitle: NullableText(
              routeSequence.mode,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Stop point sequences'),
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteSequenceStopPointSequencesPage.routeName,
                arguments: routeSequence,
              );
            },
          ),
        ],
      ),
    );
  }
}
