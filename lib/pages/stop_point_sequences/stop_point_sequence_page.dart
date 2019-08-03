import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/scroll_view.dart';

class StopPointSequencePage extends StatefulWidget {
  static const route = '/stop_point_sequences/:id';

  final StopPointSequence stopPointSequence;

  StopPointSequencePage({
    Key key,
    @required this.stopPointSequence,
  }) : super(key: key);

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
      body: StopPointSequenceListView(
        context: context,
        stopPointSequence: widget.stopPointSequence,
      ),
    );
  }
}
