import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../../common/circular_progress_indicator_future_builder.dart';
import '../../widgets/line_disruption_list_tile.dart';

class LineLineDisruptionsPage extends StatefulWidget {
  const LineLineDisruptionsPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LineLineDisruptionsPage> createState() {
    return _LineLineDisruptionsPageState();
  }
}

class _LineLineDisruptionsPageState extends State<LineLineDisruptionsPage> {
  late final Future<List<Disruption>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Disruption>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return LineDisruptionListTile(
                  lineDisruption: data[index],
                );
              },
              itemCount: data.length,
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

    _future = context.read<TflApiClient>().line.disruption([widget.id]);
  }
}
