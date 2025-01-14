import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'stop_point_filters_notifier.dart';

class StopPointFiltersScreen extends StatefulWidget {
  const StopPointFiltersScreen({
    super.key,
  });

  @override
  State<StopPointFiltersScreen> createState() {
    return _StopPointFiltersScreenState();
  }
}

class _StopPointFiltersScreenState extends State<StopPointFiltersScreen> {
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
