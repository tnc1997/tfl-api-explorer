import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_disruption_list_tile.dart';

class LineLineDisruptionsPage extends StatelessWidget {
  static const routeName = '/lines/:id/line_disruptions';

  LineLineDisruptionsPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    final lineDisruptionsFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lines.getLineDisruptions(line.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Line disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineDisruption>>(
        future: lineDisruptionsFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return LineDisruptionListTile(
                lineDisruption: data[index],
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
