import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../notifiers/line_predictions_filters_change_notifier.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/text.dart';

class LinePredictionsFiltersPage extends StatefulWidget {
  final Line line;

  LinePredictionsFiltersPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LinePredictionsFiltersPageState createState() =>
      _LinePredictionsFiltersPageState();
}

class _LinePredictionsFiltersPageState
    extends State<LinePredictionsFiltersPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
        builder: (context, data) {
          return Consumer<LinePredictionsFiltersChangeNotifier>(
            builder: (context, linePredictionsFilters, child) {
              return ListView(
                children: <Widget>[
                  ExpansionTile(
                    leading: SizedBox(),
                    title: Text('Station name'),
                    children: data.map((stopPoint) {
                      return RadioListTile<String>(
                        value: stopPoint.commonName,
                        groupValue: linePredictionsFilters.stationName,
                        onChanged: (value) {
                          linePredictionsFilters.stationName = value;
                        },
                        title: NullableText(
                          stopPoint.commonName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                  ExpansionTile(
                    leading: SizedBox(),
                    title: Text('Destination name'),
                    children: data.map((stopPoint) {
                      return RadioListTile<String>(
                        value: stopPoint.commonName,
                        groupValue: linePredictionsFilters.destinationName,
                        onChanged: (value) {
                          linePredictionsFilters.destinationName = value;
                        },
                        title: NullableText(
                          stopPoint.commonName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                ],
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

    final tflApi = Provider.of<TflApiState>(
      context,
      listen: false,
    );
    _stopPointsFuture = tflApi.tflApi.lines.getStopPoints(
      widget.line.id,
    );
  }
}
