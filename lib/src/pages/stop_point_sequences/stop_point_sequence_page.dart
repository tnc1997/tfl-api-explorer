import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_stop_points_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointSequencePage extends StatefulWidget {
  static const route = '/stop_point_sequences/:id';

  final StopPointSequence stopPointSequence;

  StopPointSequencePage({
    Key key,
    @required this.stopPointSequence,
  }) : super(
          key: key,
        );

  @override
  _StopPointSequencePageState createState() => _StopPointSequencePageState();
}

class _StopPointSequencePageState extends State<StopPointSequencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.stopPointSequence.branchId}'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Line name'),
            subtitle: NullableText(
              widget.stopPointSequence.lineName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Service type'),
            subtitle: NullableText(
              widget.stopPointSequence.serviceType,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Stop points'),
            onTap: () {
              Navigator.of(context).pushNamed(
                StopPointSequenceStopPointsPage.route,
                arguments: widget.stopPointSequence,
              );
            },
          ),
        ],
      ),
    );
  }
}
