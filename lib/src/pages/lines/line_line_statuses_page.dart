import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_status_list_tile.dart';

class LineLineStatusesPage extends StatefulWidget {
  static const routeName = '/lines/:id/line_statuses';

  LineLineStatusesPage({
    Key? key,
    required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LineLineStatusesPageState createState() => _LineLineStatusesPageState();
}

class _LineLineStatusesPageState extends State<LineLineStatusesPage> {
  late Future<List<LineStatus>> _lineStatusesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line statuses'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineStatus>>(
        future: _lineStatusesFuture,
        builder: (context, data) {
          if (data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return LineStatusListTile(
                  lineStatus: data[index],
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

    _lineStatusesFuture = context
        .read<TflApiClient>()
        .lines
        .statusByIdsByPathIdsQueryDetail([widget.line.id!]).then(
            (value) => value.first.lineStatus ?? []);
  }
}
