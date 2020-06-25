import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_disruption_list_tile.dart';

class LineLineDisruptionsPage extends StatefulWidget {
  static const routeName = '/lines/:id/line_disruptions';

  LineLineDisruptionsPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LineLineDisruptionsPageState createState() =>
      _LineLineDisruptionsPageState();
}

class _LineLineDisruptionsPageState extends State<LineLineDisruptionsPage> {
  Future<List<LineDisruption>> _lineDisruptionsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineDisruption>>(
        future: _lineDisruptionsFuture,
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

  @override
  void initState() {
    super.initState();

    _lineDisruptionsFuture =
        context.read<TflApi>().lines.getLineDisruptions(widget.line.id);
  }
}
