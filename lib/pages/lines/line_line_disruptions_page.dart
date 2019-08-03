import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../notifiers/tfl_api_change_notifier.dart';
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
  StreamController<List<LineDisruption>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line disruptions'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getLineDisruptions = () {
            return tflApi.tflApi.lines.getLineDisruptions(widget.line.id);
          };

          getLineDisruptions()
              .then(_streamController.add)
              .catchError(_streamController.addError);

          return CircularProgressIndicatorStreamBuilder<List<LineDisruption>>(
            stream: _streamController.stream,
            builder: (context, data) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return LineDisruptionListTile(
                      context: context,
                      lineDisruption: data[index],
                    );
                  },
                  itemCount: data.length,
                ),
                onRefresh: () {
                  return getLineDisruptions()
                      .then(_streamController.add)
                      .catchError(_streamController.addError);
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<List<LineDisruption>>();
  }
}
