import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/stop_point_sequences/stop_point_sequence_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointSequenceListTile extends StatelessWidget {
  StopPointSequenceListTile({
    Key key,
    @required this.stopPointSequence,
  }) : super(
          key: key,
        );

  final StopPointSequence stopPointSequence;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        stopPointSequence.branchId?.toString(),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        stopPointSequence.serviceType,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          StopPointSequencePage.route,
          arguments: stopPointSequence,
        );
      },
    );
  }
}
