import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../notifiers/tfl_api_change_notifier.dart';
import '../../widgets/async.dart';

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
  StreamController<List<StopPoint>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getStopPoints = () {
            return tflApi.tflApi.lines.getStopPoints(widget.line.id);
          };

          getStopPoints()
              .then(_streamController.add)
              .catchError(_streamController.addError);

          return CircularProgressIndicatorStreamBuilder<List<StopPoint>>(
            stream: _streamController.stream,
            builder: (context, data) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return StopPointListTile(
                      context: context,
                      stopPoint: data[index],
                    );
                  },
                  itemCount: data.length,
                ),
                onRefresh: () {
                  return getStopPoints()
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

    _streamController = StreamController<List<StopPoint>>();
  }
}
