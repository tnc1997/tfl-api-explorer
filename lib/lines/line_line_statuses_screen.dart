import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'line_status_list_tile.dart';

class LineLineStatusesScreen extends StatefulWidget {
  const LineLineStatusesScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LineLineStatusesScreen> createState() {
    return _LineLineStatusesScreenState();
  }
}

class _LineLineStatusesScreenState extends State<LineLineStatusesScreen> {
  late final Future<List<Line>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line statuses'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _future,
        builder: (context, data) {
          if (data?[0].lineStatuses case final lineStatuses?) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return LineStatusListTile(
                  lineStatus: lineStatuses[index],
                );
              },
              itemCount: lineStatuses.length,
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

    _future = context.read<TflApiClient>().line.statusByIds([widget.id]);
  }
}
