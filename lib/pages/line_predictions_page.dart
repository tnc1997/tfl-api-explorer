import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LinePredictionsPage extends StatefulWidget {
  static const route = '/lines/:id/predictions';

  final String id;

  LinePredictionsPage({Key key, @required this.id}) : super(key: key);

  @override
  _LinePredictionsPageState createState() => _LinePredictionsPageState();
}

class _LinePredictionsPageState extends State<LinePredictionsPage> {
  final _streamController = StreamController<List<Prediction>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getPredictions = () {
            return tflApi.tflApi.lines.getPredictions(widget.id);
          };

          getPredictions().then(_streamController.add);

          return CircularProgressIndicatorStreamBuilder<List<Prediction>>(
            stream: _streamController.stream,
            builder: (context, data) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: NullableText(
                        data[index].id,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text('Vehicle'),
                          subtitle: NullableText(
                            data[index].vehicleId,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ListTile(
                          title: Text('Stop Point'),
                          subtitle: NullableText(
                            data[index].stationName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ListTile(
                          title: Text('Platform'),
                          subtitle: NullableText(
                            data[index].platformName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ListTile(
                          title: Text('Destination'),
                          subtitle: NullableText(
                            data[index].destinationName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ListTile(
                          title: Text('Current Location'),
                          subtitle: NullableText(
                            data[index].currentLocation,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ListTile(
                          title: Text('Expected Arrival'),
                          subtitle: NullableText(
                            data[index].expectedArrival?.toIso8601String(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: data.length,
                ),
                onRefresh: () async {
                  final lineDisruptions = await getPredictions();

                  _streamController.add(lineDisruptions);
                },
              );
            },
          );
        },
      ),
    );
  }
}
