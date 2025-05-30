import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'route_sequence_list_tile.dart';

class LineRouteSequencesScreen extends StatefulWidget {
  const LineRouteSequencesScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LineRouteSequencesScreen> createState() {
    return _LineRouteSequencesScreenState();
  }
}

class _LineRouteSequencesScreenState extends State<LineRouteSequencesScreen> {
  late final Future<RouteSequence> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route sequences'),
      ),
      body: CircularProgressIndicatorFutureBuilder<RouteSequence>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RouteSequenceListTile(
                  routeSequence: data,
                );
              },
              itemCount: 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _future =
        context.read<TflApiClient>().line.routeSequence(widget.id, 'inbound');
  }
}
