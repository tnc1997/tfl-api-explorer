import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_filters_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_list_tile.dart';

class StopPointsPage extends StatelessWidget {
  static const routeName = '/stop_points';

  StopPointsPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final stopPointsFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).stopPoints.get(type: 'NaptanMetroStation').then((stopPoints) {
      return stopPoints..sort((a, b) => a.id.compareTo(b.id));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Points'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.filter),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return StopPointFiltersPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: stopPointsFuture,
        builder: (context, data) {
          return Consumer<StopPointFiltersChangeNotifier>(
            builder: (context, stopPointFiltersChangeNotifier, child) {
              final stopPoints = data
                  .where(stopPointFiltersChangeNotifier.areSatisfiedBy)
                  .toList();

              return ListView.builder(
                itemBuilder: (context, index) {
                  return StopPointListTile(
                    stopPoint: stopPoints[index],
                  );
                },
                itemCount: stopPoints.length,
              );
            },
          );
        },
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }
}
