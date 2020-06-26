import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';
import 'package:tfl_api_explorer/src/widgets/line_list_tile.dart';

class LinesPage extends StatefulWidget {
  static const routeName = '/lines';

  @override
  _LinesPageState createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  Future<List<Line>> _linesFuture;

  @override
  Widget build(BuildContext context) {
    final lineFiltersChangeNotifier =
        context.watch<LineFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.filter),
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
              data.where(lineFiltersChangeNotifier.areSatisfiedBy).toList();

          return ListView.builder(
            itemBuilder: (context, index) {
              return LineListTile(
                line: lines[index],
              );
            },
            itemCount: lines.length,
          );
        },
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }

  @override
  void initState() {
    super.initState();

    _linesFuture = context.read<TflApi>().lines.get();
  }
}

class _LineFiltersPage extends StatefulWidget {
  @override
  _LineFiltersPageState createState() => _LineFiltersPageState();
}

class _LineFiltersPageState extends State<_LineFiltersPage> {
  Future<List<Mode>> _lineModesFuture;

  @override
  Widget build(BuildContext context) {
    final lineFiltersChangeNotifier =
        context.watch<LineFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
            onPressed: () {
              lineFiltersChangeNotifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_lineModesFuture]),
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              ExpansionTile(
                title: Text('Mode name'),
                children: (data[0] as List<Mode>).map((mode) {
                  return RadioListTile<String>(
                    value: mode.modeName,
                    groupValue: lineFiltersChangeNotifier.modeName,
                    onChanged: (value) {
                      lineFiltersChangeNotifier.modeName = value;
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

    _lineModesFuture = context.read<TflApi>().lineModes.get();
  }
}
