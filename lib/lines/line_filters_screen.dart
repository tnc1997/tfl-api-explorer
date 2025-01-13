import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/reset_filters_button.dart';
import 'line_filters_list_view.dart';
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
            return LineFiltersListView(
              modes: data,
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
