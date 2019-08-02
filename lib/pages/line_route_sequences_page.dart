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
                    final lineStrings = data[index].lineStrings.map(
                      (lineString) {
                        return lineString
                            .substring(3, lineString.length - 3)
                            .split('],[');
                      },
                    ).fold<List<String>>(
                      <String>[],
                      (previousValue, element) {
                        return previousValue..addAll(element);
                      },
                    ).toList();

                    final stopPoints = data[index].stopPointSequences.map(
                      (stopPointSequence) {
                        return stopPointSequence.stopPoint;
                      },
                    ).fold<List<MatchedStop>>(
                      <MatchedStop>[],
                      (previousValue, element) {
                        return previousValue..addAll(element);
                      },
                    ).toList();

                    return ExpansionTile(
                      title: NullableText(
                        data[index].direction,
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: <Widget>[
                        ExpansionTile(
                          title: Text('Line Strings'),
                          children: lineStrings.map((lineString) {
                            return ListTile(
                              title: Text('Lat Lon'),
                              subtitle: NullableText(
                                lineString,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ),
                        ExpansionTile(
                            title: Text('Stop Points'),
                            children: stopPoints.map((stopPoint) {
                              return ListTile(
                                title: NullableText(
                                  stopPoint.id,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: NullableText(
                                  stopPoint.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  /*Navigator.of(context).pushNamed(
                                    StopPointPage.route,
                                    arguments: stopPoint.id,
                                  );*/
                                },
                              );
                            }).toList()),
                      ],
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
