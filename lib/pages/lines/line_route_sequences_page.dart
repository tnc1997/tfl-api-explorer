import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/basic.dart';

class LineRouteSequencesPage extends StatefulWidget {
  static const route = '/lines/:id/route_sequences';

  final Line line;

  LineRouteSequencesPage({
    Key key,
    @required this.line,
  }) : super(key: key);

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
                  context: context,
                  routeSequence: data[index],
                );
              },
              itemCount: data.length,
            );
          } else {
            return TextCenter('N/A');
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
