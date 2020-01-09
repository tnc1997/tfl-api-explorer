import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LinePredictionStationNameFilterPage extends StatelessWidget {
  LinePredictionStationNameFilterPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    final stopPointsFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lines.getStopPoints(line.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Station name'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: stopPointsFuture,
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
}
