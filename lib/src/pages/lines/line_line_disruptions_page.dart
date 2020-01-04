import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_disruption_list_tile.dart';

class LineLineDisruptionsPage extends StatefulWidget {
  static const route = '/lines/:id/line_disruptions';

  final Line line;

  LineLineDisruptionsPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  @override
  _LineLineDisruptionsPageState createState() =>
      _LineLineDisruptionsPageState();
}

class _LineLineDisruptionsPageState extends State<LineLineDisruptionsPage> {
  Future<List<LineDisruption>> _lineDisruptionsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineDisruption>>(
        future: _lineDisruptionsFuture,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return LineDisruptionListTile(
                  lineDisruption: data[index],
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
    _lineDisruptionsFuture = tflApi.tflApi.lines.getLineDisruptions(
      widget.line.id,
    );
  }
}
