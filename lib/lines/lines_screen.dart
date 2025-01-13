import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import 'line_filters_button.dart';
import 'line_filters_notifier.dart';
import 'line_list_view.dart';

class LinesScreen extends StatefulWidget {
  const LinesScreen({
    super.key,
  });

  @override
  State<LinesScreen> createState() {
    return _LinesScreenState();
  }
}

class _LinesScreenState extends State<LinesScreen> {
  late Future<List<Line>>? _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
        actions: <Widget>[
          const LineFiltersButton(),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return LineListView(
              lines: data,
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

    final modes = context.watch<LineFiltersNotifier>().modes;

    if (modes.isEmpty) {
      modes.add('bus');
    }

    _future = context.read<TflApiClient>().line.getByMode(modes);
  }
}

class _LineFiltersPage extends StatefulWidget {
  @override
  State<_LineFiltersPage> createState() {
    return _LineFiltersPageState();
  }
}

class _LineFiltersPageState extends State<_LineFiltersPage> {
  late final Future<List<Mode>> _future;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LineFiltersNotifier>();

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
