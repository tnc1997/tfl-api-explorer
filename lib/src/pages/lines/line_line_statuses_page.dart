import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_status_list_tile.dart';

class LineLineStatusesPage extends StatelessWidget {
  static const routeName = '/lines/:id/line_statuses';

  LineLineStatusesPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    final lineStatusesFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lines.getLineStatuses(line.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Line statuses'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineStatus>>(
        future: lineStatusesFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return LineStatusListTile(
                lineStatus: data[index],
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
