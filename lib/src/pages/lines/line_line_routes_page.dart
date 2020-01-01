import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/material/list_tile.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_route_filters_page.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/async.dart';
import 'package:tfl_api_explorer/src/widgets/basic.dart';

class LineLineRoutesPage extends StatefulWidget {
  static const route = '/lines/:id/line_routes';

  final Line line;

  LineLineRoutesPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LineLineRoutesPageState createState() => _LineLineRoutesPageState();
}

class _LineLineRoutesPageState extends State<LineLineRoutesPage> {
  Future<List<LineRoute>> _lineRoutesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LineLineRouteFiltersPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineRoute>>(
        future: _lineRoutesFuture,
        builder: (context, data) {
          return Consumer<LineLineRouteFiltersChangeNotifier>(
            builder: (context, lineLineRouteFilters, child) {
              if (data != null && data.isNotEmpty) {
                final lineRoutes =
                    data.where(lineLineRouteFilters.areSatisfiedBy).toList();

                return ListView.builder(
                  itemBuilder: (context, index) {
                    return LineRouteListTile(
                      context: context,
                      lineRoute: lineRoutes[index],
                    );
                  },
                  itemCount: lineRoutes.length,
                );
              } else {
                return TextCenter('N/A');
              }
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _lineRoutesFuture = Provider.of<TflApiState>(
      context,
      listen: false,
    ).tflApi.lines.getLineRoutes(widget.line.id);
  }
}
