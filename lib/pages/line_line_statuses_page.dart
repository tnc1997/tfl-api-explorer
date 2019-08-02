import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/line_line_statuses_filter_change_notifier.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';
import 'line_line_statuses_filter_page.dart';

class LineLineStatusesPage extends StatefulWidget {
  static const route = '/lines/:id/line_statuses';

  final String id;

  LineLineStatusesPage({Key key, @required this.id}) : super(key: key);

  @override
  _LineLineStatusesPageState createState() => _LineLineStatusesPageState();
}

class _LineLineStatusesPageState extends State<LineLineStatusesPage> {
  final _streamController = StreamController<List<LineStatus>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line statuses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LineLineStatusesFilterPage();
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          return Consumer<LineLineStatusesFilterChangeNotifier>(
            builder: (context, lineLineStatusesFilter, child) {
              final getLineStatuses = () {
                return tflApi.tflApi.lines.getLineStatuses(
                  widget.id,
                  startDate: lineLineStatusesFilter.date?.toIso8601String(),
                  endDate: lineLineStatusesFilter.date
                      ?.add(Duration(days: 1))
                      ?.toIso8601String(),
                );
              };

              getLineStatuses()
                  .then(_streamController.add)
                  .catchError(_streamController.addError);

              return CircularProgressIndicatorStreamBuilder<List<LineStatus>>(
                stream: _streamController.stream,
                builder: (context, data) {
                  return RefreshIndicator(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text(
                            data[index].statusSeverityDescription,
                            overflow: TextOverflow.ellipsis,
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Reason'),
                              subtitle: NullableText(
                                data[index].reason,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              isThreeLine: true,
                            ),
                            ListTile(
                              title: Text('Created'),
                              subtitle: NullableText(
                                data[index].created?.toIso8601String(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ListTile(
                              title: Text('Modified'),
                              subtitle: NullableText(
                                data[index].modified?.toIso8601String(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: data.length,
                    ),
                    onRefresh: () async {
                      final lineDisruptions = await getLineStatuses();

                      _streamController.add(lineDisruptions);
                    },
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
