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
  _LineLineDisruptionsPageState createState() =>
      _LineLineDisruptionsPageState();
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

          getLineDisruptions()
              .then(_streamController.add)
              .catchError(_streamController.addError);

          return CircularProgressIndicatorStreamBuilder<List<LineDisruption>>(
            stream: _streamController.stream,
            builder: (context, data) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: NullableText(
                        data[index].category,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text('Description'),
                          subtitle: NullableText(
                            data[index].description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          isThreeLine: true,
                        ),
                        ListTile(
                          title: Text('Summary'),
                          subtitle: NullableText(
                            data[index].summary,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          isThreeLine: true,
                        ),
                        ListTile(
                          title: Text('Information'),
                          subtitle: NullableText(
                            data[index].additionalInfo,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          isThreeLine: true,
                        ),
                      ],
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
