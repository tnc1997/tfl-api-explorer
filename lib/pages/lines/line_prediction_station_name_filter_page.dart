import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../notifiers/line_prediction_filters_change_notifier.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/text.dart';

class LinePredictionStationNameFilterPage extends StatefulWidget {
  final Line line;

  LinePredictionStationNameFilterPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LinePredictionStationNameFilterPageState createState() =>
      _LinePredictionStationNameFilterPageState();
}

class _LinePredictionStationNameFilterPageState
    extends State<LinePredictionStationNameFilterPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Station name'),
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
                    groupValue: linePredictionFilters.stationName,
                    onChanged: (value) {
                      linePredictionFilters.stationName = value;
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
