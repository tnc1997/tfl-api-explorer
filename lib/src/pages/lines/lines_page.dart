import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_filters_page.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/drawer.dart' as drawer;
import 'package:tfl_api_explorer/src/widgets/line_list_tile.dart';

class LinesPage extends StatefulWidget {
  static const route = '/lines';

  LinesPage({
    Key key,
  }) : super(
          key: key,
        );

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
                      line: lines[index],
                    );
                  },
                  itemCount: lines.length,
                );
              } else {
                return Center(
                  child: Text('N/A'),
                );
              }
            },
          );
        },
      ),
      drawer: drawer.Drawer(),
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
