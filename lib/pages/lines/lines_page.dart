import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../notifiers/lines_filters_change_notifier.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/drawer.dart';
import 'lines_filters_page.dart';

class LinesPage extends StatefulWidget {
  static const route = '/lines';

  LinesPage({Key key}) : super(key: key);

  @override
  _LinesPageState createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  Future<List<Line>> _linesFuture;

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
                    return LinesFiltersPage();
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _linesFuture,
        builder: (context, data) {
          return Consumer<LinesFiltersChangeNotifier>(
            builder: (context, linesFilters, child) {
              var lines = data.toList();

              if (linesFilters.specification != null) {
                lines = lines
                    .where(
                      linesFilters.specification.isSatisfiedBy,
                    )
                    .toList();
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return LineListTile(
                    context: context,
                    line: lines[index],
                  );
                },
                itemCount: lines.length,
              );
            },
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }

  @override
  void initState() {
    super.initState();

    final tflApi = Provider.of<TflApiState>(
      context,
      listen: false,
    );
    final linesFilters = Provider.of<LinesFiltersChangeNotifier>(
      context,
      listen: false,
    );
    _linesFuture = tflApi.tflApi.lines.get(
      mode: linesFilters.modeName,
    );
  }
}
