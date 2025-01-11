import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/circular_progress_indicator_stream_builder.dart';
import '../predictions/prediction_list_tile.dart';
import 'line_prediction_filters_notifier.dart';

class LinePredictionsPage extends StatefulWidget {
  const LinePredictionsPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LinePredictionsPage> createState() {
    return _LinePredictionsPageState();
  }
}

class _LinePredictionsPageState extends State<LinePredictionsPage> {
  final _predictionsStreamController = StreamController<List<Prediction>>();

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LinePredictionFiltersNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _LinePredictionFiltersPage(
                      id: widget.id,
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
          final predictions = data?.where(notifier.areSatisfiedBy).toList();

          if (predictions != null) {
            return RefreshIndicator(
              onRefresh: _refreshPredictions,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return PredictionListTile(
                    prediction: predictions[index],
                  );
                },
                itemCount: predictions.length,
              ),
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
      final notifier = context.read<LinePredictionFiltersNotifier>();

      var predictions =
          await context.read<TflApiClient>().line.arrivals([widget.id]);

      predictions = predictions.where(notifier.areSatisfiedBy).toList();

      _predictionsStreamController.add(predictions);
    } catch (error) {
      _predictionsStreamController.addError(error);
    }
  }
}

class _LinePredictionFiltersPage extends StatefulWidget {
  const _LinePredictionFiltersPage({
    required this.id,
  });

  final String id;

  @override
  State<_LinePredictionFiltersPage> createState() {
    return _LinePredictionFiltersPageState();
  }
}

class _LinePredictionFiltersPageState
    extends State<_LinePredictionFiltersPage> {
  late Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LinePredictionFiltersNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              notifier.reset();
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
                      groupValue: notifier.stationName,
                      onChanged: (value) {
                        notifier.stationName = value;
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
                      groupValue: notifier.destinationName,
                      onChanged: (value) {
                        notifier.destinationName = value;
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

    _stopPointsFuture = context.read<TflApiClient>().line.stopPoints(widget.id);
  }
}
