import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/radio_list_tile.dart';
import '../../notifiers/line_predictions_filters_change_notifier.dart';
import '../../notifiers/tfl_api_change_notifier.dart';
import '../../widgets/async.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LinePredictionsFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          return CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
            future: tflApi.tflApi.lines.getStopPoints(widget.line.id),
            builder: (context, data) {
              return Consumer<LinePredictionsFiltersChangeNotifier>(
                builder: (context, linePredictionsFilters, child) {
                  return ListView(
                    children: <Widget>[
                      ExpansionTile(
                        leading: SizedBox(),
                        title: Text('Stop point'),
                        children: data.map((stopPoint) {
                          return StopPointRadioListTile(
                            value: stopPoint,
                            groupValue: linePredictionsFilters.stopPoint,
                            onChanged: (stopPoint) {
                              linePredictionsFilters.stopPoint = stopPoint;
                            },
                          );
                        }).toList(),
                      ),
                      ExpansionTile(
                        leading: SizedBox(),
                        title: Text('Destination'),
                        children: data.map((stopPoint) {
                          return StopPointRadioListTile(
                            value: stopPoint,
                            groupValue: linePredictionsFilters.destination,
                            onChanged: (stopPoint) {
                              linePredictionsFilters.destination = stopPoint;
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
