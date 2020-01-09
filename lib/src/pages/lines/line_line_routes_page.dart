import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_route_filters_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_route_list_tile.dart';

class LineLineRoutesPage extends StatelessWidget {
  static const routeName = '/lines/:id/line_routes';

  LineLineRoutesPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    final lineRoutesFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lines.getLineRoutes(line.id);

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
        future: lineRoutesFuture,
        builder: (context, data) {
          return Consumer<LineLineRouteFiltersChangeNotifier>(
            builder: (context, lineLineRouteFiltersChangeNotifier, child) {
              final lineRoutes = data
                  .where(lineLineRouteFiltersChangeNotifier.areSatisfiedBy)
                  .toList();

              return ListView.builder(
                itemBuilder: (context, index) {
                  return LineRouteListTile(
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
}
