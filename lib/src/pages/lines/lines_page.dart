import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_filters_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';
import 'package:tfl_api_explorer/src/widgets/line_list_tile.dart';

class LinesPage extends StatelessWidget {
  static const routeName = '/lines';

  LinesPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final linesFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lines.get();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.filter),
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
        future: linesFuture,
        builder: (context, data) {
          return Consumer<LineFiltersChangeNotifier>(
            builder: (context, lineFiltersChangeNotifier, child) {
              final lines =
                  data.where(lineFiltersChangeNotifier.areSatisfiedBy).toList();

              return ListView.builder(
                itemBuilder: (context, index) {
                  return LineListTile(
                    line: lines[index],
                  );
                },
                itemCount: lines.length,
              );
            },
          );
        },
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }
}
