import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../pages/stop_point_sequences/stop_point_sequence_page.dart';

class StopPointSequenceListTile extends StatelessWidget {
  const StopPointSequenceListTile({
    super.key,
    required this.stopPointSequence,
  });

  final StopPointSequence stopPointSequence;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        stopPointSequence.branchId?.toString() ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        stopPointSequence.serviceType ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return StopPointSequencePage(
                stopPointSequence: stopPointSequence,
              );
            },
          ),
        );
      },
    );
  }
}
