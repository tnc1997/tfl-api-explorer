import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/route_sequences/route_sequence_stop_point_sequences_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class RouteSequencePage extends StatefulWidget {
  static const route = '/route_sequences/:id';

  final RouteSequence routeSequence;

  RouteSequencePage({
    Key key,
    @required this.routeSequence,
  }) : super(
          key: key,
        );

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
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Line name'),
            subtitle: NullableText(
              widget.routeSequence.lineName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Mode'),
            subtitle: NullableText(
              widget.routeSequence.mode,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Stop point sequences'),
            onTap: () {
              Navigator.of(context).pushNamed(
                RouteSequenceStopPointSequencesPage.route,
                arguments: widget.routeSequence,
              );
            },
          ),
        ],
      ),
    );
  }
}
