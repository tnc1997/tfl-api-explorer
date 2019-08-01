import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LineLineDisruptionsPage extends StatefulWidget {
  static const route = '/lines/:id/line_disruptions';

  final String id;

  LineLineDisruptionsPage({Key key, @required this.id}) : super(key: key);

  @override
  _LineLineDisruptionsPageState createState() => _LineLineDisruptionsPageState();
}

class _LineLineDisruptionsPageState extends State<LineLineDisruptionsPage> {
  final _streamController = StreamController<List<LineDisruption>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line Disruptions'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getLineDisruptions = () {
            return tflApi.tflApi.lines.getLineDisruptions(widget.id);
          };

          getLineDisruptions().then(_streamController.add);

          return CircularProgressIndicatorStreamBuilder<List<LineDisruption>>(
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
                                  data[index].category,
                                  style: Theme.of(context).textTheme.headline,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Description',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].description,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Summary',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].summary,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Information',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].additionalInfo,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Created',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].created?.toIso8601String(),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Updated',
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: NullableText(
                                  data[index].lastUpdate?.toIso8601String(),
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
                  final lineDisruptions = await getLineDisruptions();

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
