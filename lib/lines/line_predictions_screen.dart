import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/circular_progress_indicator_stream_builder.dart';
import '../predictions/prediction_list_tile.dart';
import 'line_prediction_filters_notifier.dart';

class LinePredictionsScreen extends StatefulWidget {
  const LinePredictionsScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LinePredictionsScreen> createState() {
    return _LinePredictionsScreenState();
  }
}

class _LinePredictionsScreenState extends State<LinePredictionsScreen> {
  final _controller = StreamController<List<Prediction>>();

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
        stream: _controller.stream,
        builder: (context, data) {
          final predictions = data?.where(
            (prediction) {
              if (notifier.destinationName case final destinationName?) {
                if (prediction.destinationName != destinationName) {
                  return false;
                }
              }

              if (notifier.stationName case final stationName?) {
                if (prediction.stationName != stationName) {
                  return false;
                }
              }

              return true;
            },
          ).toList();

          if (predictions != null) {
            return RefreshIndicator(
              onRefresh: _refresh,
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

    _controller.close();
  }

  @override
  void initState() {
    super.initState();

    _refresh();
  }

  Future<void> _refresh() async {
    try {
      _controller.add(
        await context.read<TflApiClient>().line.arrivals([widget.id]),
      );
    } catch (error) {
      _controller.addError(
        error,
      );
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
  late final Future<List<StopPoint>> _future;

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
        future: Future.wait([_future]),
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

    _future = context.read<TflApiClient>().line.stopPoints(widget.id);
  }
}
