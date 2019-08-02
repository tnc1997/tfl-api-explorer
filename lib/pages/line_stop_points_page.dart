import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LineStopPointsPage extends StatefulWidget {
  static const route = '/lines/:id/stop_points';

  final String id;

  LineStopPointsPage({Key key, @required this.id}) : super(key: key);

  @override
  _LineStopPointsPageState createState() => _LineStopPointsPageState();
}

class _LineStopPointsPageState extends State<LineStopPointsPage> {
  StreamController<List<StopPoint>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getStopPoints = () {
            return tflApi.tflApi.lines.getStopPoints(widget.id);
          };

          getStopPoints()
              .then(_streamController.add)
              .catchError(_streamController.addError);

          return CircularProgressIndicatorStreamBuilder<List<StopPoint>>(
            stream: _streamController.stream,
            builder: (context, data) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: NullableText(
                        data[index].naptanId,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: NullableText(
                        data[index].commonName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        /*Navigator.of(context).pushNamed(
                          StopPointPage.route,
                          arguments: data[index].id,
                        );*/
                      },
                    );
                  },
                  itemCount: data.length,
                ),
                onRefresh: () {
                  return getStopPoints()
                      .then(_streamController.add)
                      .catchError(_streamController.addError);
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<List<StopPoint>>();
  }
}
