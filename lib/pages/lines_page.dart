import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../material/list_tile.dart';
import '../notifiers/lines_filter_change_notifier.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/drawer.dart';
import 'lines_filter_page.dart';

class LinesPage extends StatefulWidget {
  static const route = '/lines';

  LinesPage({Key key}) : super(key: key);

  @override
  _LinesPageState createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  StreamController<List<Line>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LinesFilterPage();
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
          return Consumer<LinesFilterChangeNotifier>(
            builder: (context, linesFilter, child) {
              final getLines = () {
                return tflApi.tflApi.lines.get(
                  mode: linesFilter.mode?.modeName,
                );
              };

              getLines()
                  .then(_streamController.add)
                  .catchError(_streamController.addError);

              return CircularProgressIndicatorStreamBuilder<List<Line>>(
                stream: _streamController.stream,
                builder: (context, data) {
                  return RefreshIndicator(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return LineListTile(
                          context: context,
                          line: data[index],
                        );
                      },
                      itemCount: data.length,
                    ),
                    onRefresh: () {
                      return getLines()
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
      drawer: AppDrawer(),
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

    _streamController = StreamController<List<Line>>();
  }
}
