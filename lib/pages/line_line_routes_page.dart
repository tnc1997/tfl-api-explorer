import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LineLineRoutesPage extends StatefulWidget {
  static const route = '/lines/:id/line_routes';

  final String id;

  LineLineRoutesPage({Key key, @required this.id}) : super(key: key);

  @override
  _LineLineRoutesPageState createState() => _LineLineRoutesPageState();
}

class _LineLineRoutesPageState extends State<LineLineRoutesPage> {
  final _streamController = StreamController<List<LineRoute>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line Routes'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getLineRoutes = () {
            return tflApi.tflApi.lines.getLineRoutes(widget.id);
          };

          getLineRoutes().then(_streamController.add);

          return CircularProgressIndicatorStreamBuilder<List<LineRoute>>(
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
                                  data[index].name,
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Direction',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].direction,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Service Type',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].serviceType,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Valid To',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].validTo?.toIso8601String(),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Valid From',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].validFrom?.toIso8601String(),
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
                  final lineDisruptions = await getLineRoutes();

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
