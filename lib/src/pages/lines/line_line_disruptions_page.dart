import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_disruption_list_tile.dart';

class LineLineDisruptionsPage extends StatefulWidget {
  static const routeName = '/lines/:id/line_disruptions';

  LineLineDisruptionsPage({
    Key? key,
    required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LineLineDisruptionsPageState createState() =>
      _LineLineDisruptionsPageState();
}

class _LineLineDisruptionsPageState extends State<LineLineDisruptionsPage> {
  late Future<List<Disruption>> _lineDisruptionsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Disruption>>(
        future: _lineDisruptionsFuture,
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

    _lineDisruptionsFuture =
        context.read<TflApiClient>().line.disruption([widget.line.id!]);
  }
}
