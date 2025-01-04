import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';

class LinesPage extends StatefulWidget {
  static const routeName = '/lines';

  const LinesPage({
    super.key,
  });

  @override
  _LinesPageState createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  late Future<List<Line>> _linesFuture;

  @override
  Widget build(BuildContext context) {
    final lineFiltersChangeNotifier =
        context.watch<LineFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              Navigator.of(context).push(
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
        future: _linesFuture,
        builder: (context, data) {
          final lines =
              data?.where(lineFiltersChangeNotifier.areSatisfiedBy).toList();

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

    _linesFuture = context.read<TflApiClient>().line.getByMode(['bus', 'tube']);
  }
}

class _LineFiltersPage extends StatefulWidget {
  @override
  _LineFiltersPageState createState() => _LineFiltersPageState();
}

class _LineFiltersPageState extends State<_LineFiltersPage> {
  late Future<List<Mode>> _lineModesFuture;

  @override
  Widget build(BuildContext context) {
    final lineFiltersChangeNotifier =
        context.watch<LineFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              lineFiltersChangeNotifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_lineModesFuture]),
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Mode name'),
                  children: (data[0] as List<Mode>).map((mode) {
                    return RadioListTile<String>(
                      value: mode.modeName!,
                      groupValue: lineFiltersChangeNotifier.modeName,
                      onChanged: (value) {
                        lineFiltersChangeNotifier.modeName = value;
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

    _lineModesFuture = context.read<TflApiClient>().line.metaModes();
  }
}
