import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../material/list_tile.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';

class LineRouteSequencesPage extends StatefulWidget {
  static const route = '/lines/:id/route_sequences';

  final String id;

  LineRouteSequencesPage({Key key, @required this.id}) : super(key: key);

  @override
  _LineRouteSequencesPageState createState() => _LineRouteSequencesPageState();
}

class _LineRouteSequencesPageState extends State<LineRouteSequencesPage> {
  StreamController<List<RouteSequence>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route sequences'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          final getRouteSequences = () {
            return tflApi.tflApi.lines.getRouteSequences(widget.id);
          };

          getRouteSequences()
              .then(_streamController.add)
              .catchError(_streamController.addError);

          return CircularProgressIndicatorStreamBuilder<List<RouteSequence>>(
            stream: _streamController.stream,
            builder: (context, data) {
              return RefreshIndicator(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return RouteSequenceListTile(
                      context: context,
                      routeSequence: data[index],
                    );
                  },
                  itemCount: data.length,
                ),
                onRefresh: () {
                  return getRouteSequences()
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

    _streamController = StreamController<List<RouteSequence>>();
  }
}
