import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/drawer.dart';
import '../../material/list_tile.dart';
import '../../notifiers/line_filters_change_notifier.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/basic.dart';
import 'line_filters_page.dart';

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
                    return LineFiltersPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _linesFuture,
        builder: (context, data) {
          return Consumer<LineFiltersChangeNotifier>(
            builder: (context, lineFilters, child) {
              if (data != null && data.isNotEmpty) {
                final lines = data.where(lineFilters.areSatisfiedBy).toList();

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return LineListTile(
                      context: context,
                      line: lines[index],
                    );
                  },
                  itemCount: lines.length,
                );
              } else {
                return TextCenter('N/A');
              }
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

    _linesFuture = Provider.of<TflApiState>(
      context,
      listen: false,
    ).tflApi.lines.get();
  }
}
