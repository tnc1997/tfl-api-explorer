import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import 'stop_point_filters_notifier.dart';
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
                    return _StopPointFiltersPage();
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

class _StopPointFiltersPage extends StatefulWidget {
  @override
  State<_StopPointFiltersPage> createState() {
    return _StopPointFiltersPageState();
  }
}

class _StopPointFiltersPageState extends State<_StopPointFiltersPage> {
  late final Future<List<Mode>> _future;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<StopPointFiltersNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              notifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Mode>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Modes'),
                  children: [
                    for (final mode in data)
                      if (mode.modeName case final modeName?)
                        CheckboxListTile(
                          value: notifier.modes.contains(modeName),
                          onChanged: (value) {
                            if (value == true) {
                              notifier.addMode(modeName);
                            } else {
                              notifier.removeMode(modeName);
                            }
                          },
                          title: Text(
                            modeName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                  ],
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

    _future = context.read<TflApiClient>().stopPoint.metaModes();
  }
}
