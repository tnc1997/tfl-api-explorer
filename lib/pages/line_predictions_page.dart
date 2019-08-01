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
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].destinationName,
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Vehicle',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].vehicleId,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Stop Point',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].stationName,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Line',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].lineName,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Platform',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].platformName,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Current Location',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].currentLocation,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Expected Arrival',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].expectedArrival?.toIso8601String(),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
