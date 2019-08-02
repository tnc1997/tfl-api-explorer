import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/line_predictions_filter_change_notifier.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LinePredictionsFilterPage extends StatefulWidget {
  final String id;

  LinePredictionsFilterPage({Key key, @required this.id}) : super(key: key);

  @override
  _LinePredictionsFilterPageState createState() =>
      _LinePredictionsFilterPageState();
}

class _LinePredictionsFilterPageState extends State<LinePredictionsFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LinePredictionsFilterChangeNotifier>(
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
            future: tflApi.tflApi.lines.getStopPoints(widget.id),
            builder: (context, data) {
              return Consumer<LinePredictionsFilterChangeNotifier>(
                builder: (context, linePredictionsFilter, child) {
                  return ListView(
                    children: <Widget>[
                      ExpansionTile(
                        title: Text('Stop point'),
                        children: data.map((stopPoint) {
                          return RadioListTile<String>(
                            value: stopPoint.id,
                            groupValue: linePredictionsFilter.stopPoint,
                            onChanged: (stopPoint) {
                              linePredictionsFilter.stopPoint = stopPoint;
                            },
                            title: NullableText(
                              stopPoint.id,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: NullableText(
                              stopPoint.commonName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                      ExpansionTile(
                        title: Text('Destination'),
                        children: data.map((stopPoint) {
                          return RadioListTile<String>(
                            value: stopPoint.id,
                            groupValue: linePredictionsFilter.destination,
                            onChanged: (stopPoint) {
                              linePredictionsFilter.destination = stopPoint;
                            },
                            title: NullableText(
                              stopPoint.id,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: NullableText(
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
          );
        },
      ),
    );
  }
}
