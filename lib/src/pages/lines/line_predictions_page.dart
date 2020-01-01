import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/material/list_tile.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_prediction_filters_page.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/async.dart';
import 'package:tfl_api_explorer/src/widgets/basic.dart';

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
  StreamController<List<Prediction>> _predictionsStreamController;

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
              builder: (context, linePredictionFilters, child) {
                if (data != null && data.isNotEmpty) {
                  final predictions =
                      data.where(linePredictionFilters.areSatisfiedBy).toList();

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return PredictionListTile(
                        context: context,
                        prediction: predictions[index],
                      );
                    },
                    itemCount: predictions.length,
                  );
                } else {
                  return TextCenter('N/A');
                }
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

    _predictionsStreamController = StreamController<List<Prediction>>();

    _refreshPredictions();
  }

  Future<void> _refreshPredictions() async {
    try {
      var predictions = await Provider.of<TflApiState>(
        context,
        listen: false,
      ).tflApi.lines.getPredictions(widget.line.id);

      predictions = predictions
          .where(
            Provider.of<LinePredictionFiltersChangeNotifier>(
              context,
              listen: false,
            ).areSatisfiedBy,
          )
          .toList();

      _predictionsStreamController.add(predictions);
    } catch (error) {
      _predictionsStreamController.addError(error);
    }
  }
}
