import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/reset_filters_button.dart';
import 'line_filters_notifier.dart';

class LineFiltersScreen extends StatefulWidget {
  const LineFiltersScreen({
    super.key,
  });

  @override
  State<LineFiltersScreen> createState() {
    return _LineFiltersScreenState();
  }
}

class _LineFiltersScreenState extends State<LineFiltersScreen> {
  late final Future<List<Mode>> _future;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LineFiltersNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          const ResetFiltersButton<LineFiltersNotifier>(),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Mode>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Mode'),
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

    _future = context.read<TflApiClient>().line.metaModes();
  }
}
