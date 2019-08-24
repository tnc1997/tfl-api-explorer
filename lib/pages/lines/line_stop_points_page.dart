import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/basic.dart';

class LineStopPointsPage extends StatefulWidget {
  static const route = '/lines/:id/stop_points';

  final Line line;

  LineStopPointsPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LineStopPointsPageState createState() => _LineStopPointsPageState();
}

class _LineStopPointsPageState extends State<LineStopPointsPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return StopPointListTile(
                  context: context,
                  stopPoint: data[index],
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
    _stopPointsFuture = tflApi.tflApi.lines.getStopPoints(
      widget.line.id,
    );
  }
}
