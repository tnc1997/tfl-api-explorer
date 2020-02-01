import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_prediction_filters_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_stream_builder.dart';
import 'package:tfl_api_explorer/src/widgets/prediction_list_tile.dart';

class LinePredictionsPage extends StatefulWidget {
  static const routeName = '/lines/:id/predictions';

  LinePredictionsPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LinePredictionsPageState createState() => _LinePredictionsPageState();
}

class _LinePredictionsPageState extends State<LinePredictionsPage> {
  _LinePredictionsPageState()
      : _predictionsStreamController = StreamController<List<Prediction>>();

  final StreamController<List<Prediction>> _predictionsStreamController;

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
                    return LinePredictionFiltersPage(line: widget.line);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorStreamBuilder<List<Prediction>>(
        stream: _predictionsStreamController.stream,
        builder: (context, data) {
          return RefreshIndicator(
            child: Consumer<LinePredictionFiltersChangeNotifier>(
              builder: (context, linePredictionFiltersChangeNotifier, child) {
                final predictions =
                    data.where(linePredictionFiltersChangeNotifier.areSatisfiedBy).toList();

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return PredictionListTile(
                      prediction: predictions[index],
                    );
                  },
                  itemCount: predictions.length,
                );
              },
            ),
            onRefresh: _refreshPredictions,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _predictionsStreamController.close();
  }

  @override
  void initState() {
    super.initState();

    _refreshPredictions();
  }

  Future<void> _refreshPredictions() async {
    try {
      var predictions = await Provider.of<TflApi>(
        context,
        listen: false,
      ).lines.getPredictions(widget.line.id);

      final linePredictionFiltersChangeNotifier =
          Provider.of<LinePredictionFiltersChangeNotifier>(
        context,
        listen: false,
      );

      predictions = predictions
          .where(linePredictionFiltersChangeNotifier.areSatisfiedBy)
          .toList();

      _predictionsStreamController.add(predictions);
    } catch (error) {
      _predictionsStreamController.addError(error);
    }
  }
}
