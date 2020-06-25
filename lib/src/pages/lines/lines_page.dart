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

class _LineFiltersPage extends StatelessWidget {
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
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Mode name'),
            subtitle: NullableText(
              lineFiltersChangeNotifier.modeName,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _LineModeNameFilterPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LineModeNameFilterPage extends StatefulWidget {
  @override
  _LineModeNameFilterPageState createState() => _LineModeNameFilterPageState();
}

class _LineModeNameFilterPageState extends State<_LineModeNameFilterPage> {
  Future<List<Mode>> _lineModesFuture;

  @override
  Widget build(BuildContext context) {
    final lineFiltersChangeNotifier =
        context.watch<LineFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mode name'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Mode>>(
        future: _lineModesFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                value: data[index].modeName,
                groupValue: lineFiltersChangeNotifier.modeName,
                onChanged: (value) {
                  lineFiltersChangeNotifier.modeName = value;
                },
                title: NullableText(
                  data[index].modeName,
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

    _lineModesFuture = context.read<TflApi>().lineModes.get();
  }
}
