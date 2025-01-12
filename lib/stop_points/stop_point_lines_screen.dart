import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/identifier_list_tile.dart';

class StopPointLinesScreen extends StatefulWidget {
  const StopPointLinesScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<StopPointLinesScreen> createState() {
    return _StopPointLinesScreenState();
  }
}

class _StopPointLinesScreenState extends State<StopPointLinesScreen> {
  late final Future<List<StopPoint>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _future,
        builder: (context, data) {
          if (data?[0].lines case final lines?) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return IdentifierListTile(
                  identifier: lines[index],
                );
              },
              itemCount: lines.length,
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

    _future = context.read<TflApiClient>().stopPoint.get([widget.id]);
  }
}
