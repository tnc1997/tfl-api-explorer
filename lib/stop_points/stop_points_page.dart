import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import 'stop_point_filters_change_notifier.dart';
import 'stop_point_list_tile.dart';

class StopPointsPage extends StatefulWidget {
  const StopPointsPage({
    super.key,
  });

  @override
  State<StopPointsPage> createState() {
    return _StopPointsPageState();
  }
}

class _StopPointsPageState extends State<StopPointsPage> {
  late Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    final stopPointFiltersChangeNotifier =
        context.watch<StopPointFiltersChangeNotifier>();

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
                    return _StopPointFiltersPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
        builder: (context, data) {
          final stopPoints = data
              ?.where(stopPointFiltersChangeNotifier.areSatisfiedBy)
              .toList();

          if (stopPoints != null) {
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
  void initState() {
    super.initState();

    _stopPointsFuture = context
        .read<TflApiClient>()
        .stopPoint
        .getByType(['NaptanMetroStation']);
  }
}

class _StopPointFiltersPage extends StatefulWidget {
  @override
  State<_StopPointFiltersPage> createState() {
    return _StopPointFiltersPageState();
  }
}

class _StopPointFiltersPageState extends State<_StopPointFiltersPage> {
  late Future<List<Mode>> _stopPointModesFuture;

  @override
  Widget build(BuildContext context) {
    final stopPointFiltersChangeNotifier =
        context.watch<StopPointFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              stopPointFiltersChangeNotifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_stopPointModesFuture]),
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Modes'),
                  children: (data[0] as List<Mode>).map((mode) {
                    return CheckboxListTile(
                      value: stopPointFiltersChangeNotifier.modes
                          .contains(mode.modeName),
                      onChanged: (value) {
                        if (value != null) {
                          if (value) {
                            stopPointFiltersChangeNotifier
                                .addMode(mode.modeName!);
                          } else {
                            stopPointFiltersChangeNotifier
                                .removeMode(mode.modeName!);
                          }
                        }
                      },
                      title: Text(
                        mode.modeName ?? 'Unknown',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _stopPointModesFuture = context.read<TflApiClient>().stopPoint.metaModes();
  }
}
