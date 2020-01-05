import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LinePredictionDestinationNameFilterPage extends StatefulWidget {
  final Line line;

  LinePredictionDestinationNameFilterPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  @override
  _LinePredictionDestinationNameFilterPageState createState() =>
      _LinePredictionDestinationNameFilterPageState();
}

class _LinePredictionDestinationNameFilterPageState
    extends State<LinePredictionDestinationNameFilterPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destination name'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
        builder: (context, data) {
          return Consumer<LinePredictionFiltersChangeNotifier>(
            builder: (context, linePredictionFilters, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    value: data[index].commonName,
                    groupValue: linePredictionFilters.destinationName,
                    onChanged: (value) {
                      linePredictionFilters.destinationName = value;
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
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _stopPointsFuture = Provider.of<TflApiState>(
      context,
      listen: false,
    ).tflApi.lines.getStopPoints(widget.line.id);
  }
}
