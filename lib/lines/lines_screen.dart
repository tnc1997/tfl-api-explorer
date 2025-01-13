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
