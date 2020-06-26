import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_stream_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
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
              .where(linePredictionFiltersChangeNotifier.areSatisfiedBy)
              .toList();

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
      var predictions =
          await context.read<TflApi>().lines.getPredictions(widget.line.id);

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

class _LinePredictionFiltersPage extends StatelessWidget {
  _LinePredictionFiltersPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    final linePredictionFiltersChangeNotifier =
        context.read<LinePredictionFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
            onPressed: () {
              Provider.of<LinePredictionFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Station name'),
            subtitle: NullableText(
              linePredictionFiltersChangeNotifier.stationName,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _LinePredictionStationNameFilterPage(
                      line: line,
                    );
                  },
                ),
              );
            },
          ),
          ListTile(
            title: Text('Destination name'),
            subtitle: NullableText(
              linePredictionFiltersChangeNotifier.destinationName,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _LinePredictionDestinationNameFilterPage(
                      line: line,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LinePredictionDestinationNameFilterPage extends StatefulWidget {
  _LinePredictionDestinationNameFilterPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LinePredictionDestinationNameFilterPageState createState() =>
      _LinePredictionDestinationNameFilterPageState();
}

class _LinePredictionDestinationNameFilterPageState
    extends State<_LinePredictionDestinationNameFilterPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    final linePredictionFiltersChangeNotifier =
        context.read<LinePredictionFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Destination name'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                value: data[index].commonName,
                groupValue: linePredictionFiltersChangeNotifier.destinationName,
                onChanged: (value) {
                  linePredictionFiltersChangeNotifier.destinationName = value;
                },
                title: NullableText(
                  data[index].commonName,
                  overflow: TextOverflow.ellipsis,
                ),
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

    _stopPointsFuture =
        context.read<TflApi>().lines.getStopPoints(widget.line.id);
  }
}

class _LinePredictionStationNameFilterPage extends StatefulWidget {
  _LinePredictionStationNameFilterPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LinePredictionStationNameFilterPageState createState() =>
      _LinePredictionStationNameFilterPageState();
}

class _LinePredictionStationNameFilterPageState
    extends State<_LinePredictionStationNameFilterPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    final linePredictionFiltersChangeNotifier =
        context.read<LinePredictionFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Station name'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                value: data[index].commonName,
                groupValue: linePredictionFiltersChangeNotifier.stationName,
                onChanged: (value) {
                  linePredictionFiltersChangeNotifier.stationName = value;
                },
                title: NullableText(
                  data[index].commonName,
                  overflow: TextOverflow.ellipsis,
                ),
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

    _stopPointsFuture =
        context.read<TflApi>().lines.getStopPoints(widget.line.id);
  }
}
