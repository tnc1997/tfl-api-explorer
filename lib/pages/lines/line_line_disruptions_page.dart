import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';

class LineLineDisruptionsPage extends StatefulWidget {
  static const route = '/lines/:id/line_disruptions';

  final Line line;

  LineLineDisruptionsPage({
    Key key,
    @required this.line,
  }) : super(key: key);

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
          return ListView.builder(
            itemBuilder: (context, index) {
              return LineDisruptionListTile(
                context: context,
                lineDisruption: data[index],
              );
            },
            itemCount: data.length,
          );
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
