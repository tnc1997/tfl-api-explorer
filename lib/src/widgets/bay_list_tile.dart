import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class BayListTile extends StatelessWidget {
  BayListTile({
    Key? key,
    required this.bay,
  }) : super(
          key: key,
        );

  final Bay bay;

  @override
  Widget build(BuildContext context) {
    final occupied = bay.occupied;
    final bayCount = bay.bayCount;

    return ListTile(
      title: Text(
        bay.bayType ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: occupied != null && bayCount != null
          ? Text(
              '$occupied / $bayCount',
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: occupied != null && bayCount != null
          ? CircularProgressIndicator(
              value: occupied / bayCount,
              backgroundColor: Theme.of(context).backgroundColor,
            )
          : null,
    );
  }
}
