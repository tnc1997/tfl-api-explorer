import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_line_routes_filters_change_notifier.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import 'line_line_routes_filters_page.dart';

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
                    return LineLineRoutesFiltersPage();
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineRoute>>(
        future: _lineRoutesFuture,
        builder: (context, data) {
          return Consumer<LineLineRoutesFiltersChangeNotifier>(
            builder: (context, lineLineRoutesFilters, child) {
              var lineRoutes = data.toList();

              if (lineLineRoutesFilters.specification != null) {
                lineRoutes = lineRoutes
                    .where(
                      lineLineRoutesFilters.specification.isSatisfiedBy,
                    )
                    .toList();
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return LineRouteListTile(
                    context: context,
                    lineRoute: lineRoutes[index],
                  );
                },
                itemCount: lineRoutes.length,
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final tflApi = Provider.of<TflApiState>(
      context,
      listen: false,
    );
    final lineLineRoutesFilters =
        Provider.of<LineLineRoutesFiltersChangeNotifier>(
      context,
      listen: false,
    );
    _lineRoutesFuture = tflApi.tflApi.lines.getLineRoutes(
      widget.line.id,
      serviceTypes: <String>[lineLineRoutesFilters.serviceType],
    );
  }
}
