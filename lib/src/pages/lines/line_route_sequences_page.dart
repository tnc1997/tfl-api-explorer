import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/route_sequence_list_tile.dart';

class LineRouteSequencesPage extends StatefulWidget {
  static const route = '/lines/:id/route_sequences';

  final Line line;

  LineRouteSequencesPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  @override
  _LineRouteSequencesPageState createState() => _LineRouteSequencesPageState();
}

class _LineRouteSequencesPageState extends State<LineRouteSequencesPage> {
  Future<List<RouteSequence>> _routeSequencesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route sequences'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RouteSequence>>(
        future: _routeSequencesFuture,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RouteSequenceListTile(
                  routeSequence: data[index],
                );
              },
              itemCount: data.length,
            );
          } else {
            return Center(
              child: Text('N/A'),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final tflApi = Provider.of<TflApiState>(
      context,
      listen: false,
    );
    _routeSequencesFuture = tflApi.tflApi.lines.getRouteSequences(
      widget.line.id,
    );
  }
}
