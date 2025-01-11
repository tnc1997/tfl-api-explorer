import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import 'line_filters_notifier.dart';
import 'line_list_tile.dart';

class LinesPage extends StatefulWidget {
  const LinesPage({
    super.key,
  });

  @override
  State<LinesPage> createState() {
    return _LinesPageState();
  }
}

class _LinesPageState extends State<LinesPage> {
  late final Future<List<Line>> _future;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LineFiltersNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _LineFiltersPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _future,
        builder: (context, data) {
          final lines = data?.where(notifier.areSatisfiedBy).toList();

          if (lines != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return LineListTile(
                  line: lines[index],
                );
              },
              itemCount: lines.length,
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

    _future = context.read<TflApiClient>().line.getByMode(['bus', 'tube']);
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
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_future]),
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Mode name'),
                  children: (data[0] as List<Mode>).map((mode) {
                    return RadioListTile<String>(
                      value: mode.modeName!,
                      groupValue: notifier.modeName,
                      onChanged: (value) {
                        notifier.modeName = value;
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

    _future = context.read<TflApiClient>().line.metaModes();
  }
}
