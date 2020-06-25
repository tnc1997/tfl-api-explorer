import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_list_tile.dart';

class StopPointsPage extends StatefulWidget {
  static const routeName = '/stop_points';

  @override
  _StopPointsPageState createState() => _StopPointsPageState();
}

class _StopPointsPageState extends State<StopPointsPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    final stopPointFiltersChangeNotifier =
        context.watch<StopPointFiltersChangeNotifier>();

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
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }

  @override
  void initState() {
    super.initState();

    _stopPointsFuture = context.read<TflApi>().stopPoints.get(
          type: 'NaptanMetroStation',
        );
  }
}

class _StopPointFiltersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
            onPressed: () {
              context.read<StopPointFiltersChangeNotifier>().reset();
            },
          ),
        ],
      ),
      body: Consumer<StopPointFiltersChangeNotifier>(
        builder: (context, stopPointFiltersChangeNotifier, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Modes'),
                subtitle: Text(
                  stopPointFiltersChangeNotifier.modes.join(', '),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return _StopPointModesFilterPage();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StopPointModesFilterPage extends StatefulWidget {
  @override
  _StopPointModesFilterPageState createState() =>
      _StopPointModesFilterPageState();
}

class _StopPointModesFilterPageState extends State<_StopPointModesFilterPage> {
  Future<List<Mode>> _stopPointModesFuture;

  @override
  Widget build(BuildContext context) {
    final stopPointFiltersChangeNotifier =
        context.watch<StopPointFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Modes'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Mode>>(
        future: _stopPointModesFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final modeName = data[index].modeName;

              return CheckboxListTile(
                value: stopPointFiltersChangeNotifier.modes.contains(modeName),
                onChanged: (value) {
                  if (value) {
                    stopPointFiltersChangeNotifier.addMode(modeName);
                  } else {
                    stopPointFiltersChangeNotifier.removeMode(modeName);
                  }
                },
                title: Text(
                  modeName,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _stopPointModesFuture = context.read<TflApi>().stopPointModes.get();
  }
}
