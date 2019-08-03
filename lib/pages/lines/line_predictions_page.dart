import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_predictions_filters_change_notifier.dart';
import '../../notifiers/tfl_api_change_notifier.dart';
import '../../widgets/async.dart';
import 'line_predictions_filters_page.dart';

class LinePredictionsPage extends StatefulWidget {
  static const route = '/lines/:id/predictions';

  final Line line;

  LinePredictionsPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LinePredictionsPageState createState() => _LinePredictionsPageState();
}

class _LinePredictionsPageState extends State<LinePredictionsPage> {
  StreamController<List<Prediction>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LinePredictionsFiltersPage(line: widget.line);
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body:
          Consumer2<LinePredictionsFiltersChangeNotifier, TflApiChangeNotifier>(
        builder: (context, linePredictionsFilters, tflApi, child) {
          final getPredictions = () {
            return tflApi.tflApi.lines.getPredictions(
              widget.line.id,
              stopPointId: linePredictionsFilters.stopPoint?.id,
              destinationStationId: linePredictionsFilters.destination?.id,
            );
          };

          getPredictions()
              .then(_streamController.add)
              .catchError(_streamController.addError);

          return CircularProgressIndicatorStreamBuilder<List<Prediction>>(
            stream: _streamController.stream,
            builder: (context, data) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return PredictionListTile(
                      context: context,
                      prediction: data[index],
                    );
                  },
                  itemCount: data.length,
                ),
                onRefresh: () {
                  return getPredictions()
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

    _streamController = StreamController<List<Prediction>>();
  }
}
