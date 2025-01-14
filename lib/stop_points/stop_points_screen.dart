import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import 'stop_point_filters_notifier.dart';
import 'stop_point_filters_screen.dart';
import 'stop_point_list_tile.dart';

class StopPointsScreen extends StatefulWidget {
  const StopPointsScreen({
    super.key,
  });

  @override
  State<StopPointsScreen> createState() {
    return _StopPointsScreenState();
  }
}

class _StopPointsScreenState extends State<StopPointsScreen> {
  late Future<StopPointsResponse> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Points'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const StopPointFiltersScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<StopPointsResponse>(
        future: _future,
        builder: (context, data) {
          if (data?.stopPoints case final stopPoints?) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return StopPointListTile(
                  stopPoint: stopPoints[index],
                );
              },
              itemCount: stopPoints.length,
            );
          } else {
            return Container();
          }
        },
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final modes = context.watch<StopPointFiltersNotifier>().modes;

    if (modes.isEmpty) {
      modes.add('bus');
    }

    _future = context.read<TflApiClient>().stopPoint.getByMode(modes, page: 1);
  }
}
