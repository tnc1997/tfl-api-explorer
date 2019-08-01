import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LineRouteSequencesPage extends StatefulWidget {
  static const route = '/lines/:id/route_sequences';

  final String id;

  LineRouteSequencesPage({Key key, @required this.id}) : super(key: key);

  @override
  _LineRouteSequencesPageState createState() => _LineRouteSequencesPageState();
}

class _LineRouteSequencesPageState extends State<LineRouteSequencesPage> {
  final _streamController = StreamController<List<RouteSequence>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Sequences'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getRouteSequences = () {
            return tflApi.tflApi.lines.getRouteSequences(widget.id);
          };

          getRouteSequences().then(_streamController.add);

          return CircularProgressIndicatorStreamBuilder<List<RouteSequence>>(
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
                                  data[index].direction,
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Stop Points',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].stations.map((stopPoint) {
                                    return stopPoint.name;
                                  }).join(', '),
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
                  final lineDisruptions = await getRouteSequences();

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
