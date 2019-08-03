import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_line_statuses_filters_change_notifier.dart';
import '../../notifiers/tfl_api_change_notifier.dart';
import '../../widgets/async.dart';
import 'line_line_statuses_filters_page.dart';

class LineLineStatusesPage extends StatefulWidget {
  static const route = '/lines/:id/line_statuses';

  final Line line;

  LineLineStatusesPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LineLineStatusesPageState createState() => _LineLineStatusesPageState();
}

class _LineLineStatusesPageState extends State<LineLineStatusesPage> {
  StreamController<List<LineStatus>> _streamController;

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
                    return LineLineStatusesFiltersPage();
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
          return Consumer<LineLineStatusesFiltersChangeNotifier>(
            builder: (context, lineLineStatusesFilters, child) {
              final getLineStatuses = () {
                return tflApi.tflApi.lines.getLineStatuses(
                  widget.line.id,
                  startDate: lineLineStatusesFilters.date?.toIso8601String(),
                  endDate: lineLineStatusesFilters.date
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
                        return LineStatusListTile(
                          context: context,
                          lineStatus: data[index],
                        );
                      },
                      itemCount: data.length,
                    ),
                    onRefresh: () {
                      return getLineStatuses()
                          .then(_streamController.add)
                          .catchError(_streamController.addError);
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

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<List<LineStatus>>();
  }
}
