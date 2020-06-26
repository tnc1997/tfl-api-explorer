import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
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

class _StopPointFiltersPage extends StatefulWidget {
  @override
  _StopPointFiltersPageState createState() => _StopPointFiltersPageState();
}

class _StopPointFiltersPageState extends State<_StopPointFiltersPage> {
  Future<List<Mode>> _stopPointModesFuture;

  @override
  Widget build(BuildContext context) {
    final stopPointFiltersChangeNotifier =
        context.watch<StopPointFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
            onPressed: () {
              stopPointFiltersChangeNotifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_stopPointModesFuture]),
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              ExpansionTile(
                title: Text('Modes'),
                children: (data[0] as List<Mode>).map((mode) {
                  return CheckboxListTile(
                    value: stopPointFiltersChangeNotifier.modes
                        .contains(mode.modeName),
                    onChanged: (value) {
                      if (value) {
                        stopPointFiltersChangeNotifier.addMode(mode.modeName);
                      } else {
                        stopPointFiltersChangeNotifier
                            .removeMode(mode.modeName);
                      }
                    },
                    title: NullableText(
                      mode.modeName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ],
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
