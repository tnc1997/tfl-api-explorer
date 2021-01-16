import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_stream_builder.dart';
import 'package:tfl_api_explorer/src/widgets/prediction_list_tile.dart';

class LinePredictionsPage extends StatefulWidget {
  static const routeName = '/lines/:id/predictions';

  LinePredictionsPage({
    Key? key,
    required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LinePredictionsPageState createState() => _LinePredictionsPageState();
}

class _LinePredictionsPageState extends State<LinePredictionsPage> {
  final _predictionsStreamController = StreamController<List<Prediction>>();

  @override
  Widget build(BuildContext context) {
    final linePredictionFiltersChangeNotifier =
        context.watch<LinePredictionFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.filter),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _LinePredictionFiltersPage(
                      line: widget.line,
                    );
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
          final predictions = data
              ?.where(linePredictionFiltersChangeNotifier.areSatisfiedBy)
              .toList();

          if (predictions != null) {
            return RefreshIndicator(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return PredictionListTile(
                    prediction: predictions[index],
                  );
                },
                itemCount: predictions.length,
              ),
              onRefresh: _refreshPredictions,
            );
          } else {
            return Container();
          }
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
      var predictions = await context
          .read<TflApiClient>()
          .lines
          .arrivalsByPathIds([widget.line.id!]);

      final linePredictionFiltersChangeNotifier =
          context.read<LinePredictionFiltersChangeNotifier>();

      predictions = predictions
          .where(linePredictionFiltersChangeNotifier.areSatisfiedBy)
          .toList();

      _predictionsStreamController.add(predictions);
    } catch (error) {
      _predictionsStreamController.addError(error);
    }
  }
}

class _LinePredictionFiltersPage extends StatefulWidget {
  _LinePredictionFiltersPage({
    Key? key,
    required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LinePredictionFiltersPageState createState() =>
      _LinePredictionFiltersPageState();
}

class _LinePredictionFiltersPageState
    extends State<_LinePredictionFiltersPage> {
  late Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    final linePredictionFiltersChangeNotifier =
        context.watch<LinePredictionFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
            onPressed: () {
              linePredictionFiltersChangeNotifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_stopPointsFuture]),
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Station name'),
                  children: (data[0] as List<StopPoint>).map((stopPoint) {
                    return RadioListTile<String>(
                      value: stopPoint.commonName!,
                      groupValue:
                          linePredictionFiltersChangeNotifier.stationName,
                      onChanged: (value) {
                        linePredictionFiltersChangeNotifier.stationName = value;
                      },
                      title: Text(
                        stopPoint.commonName ?? 'Unknown',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  title: Text('Destination name'),
                  children: (data[0] as List<StopPoint>).map((stopPoint) {
                    return RadioListTile<String>(
                      value: stopPoint.commonName!,
                      groupValue:
                          linePredictionFiltersChangeNotifier.destinationName,
                      onChanged: (value) {
                        linePredictionFiltersChangeNotifier.destinationName =
                            value;
                      },
                      title: Text(
                        stopPoint.commonName ?? 'Unknown',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _stopPointsFuture = context
        .read<TflApiClient>()
        .lines
        .stopPointsByPathIdQueryTflOperatedNationalRailStationsOnly(
            widget.line.id!);
  }
}
