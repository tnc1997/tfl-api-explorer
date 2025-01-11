import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../routes/lines/line_route.dart';
import '../routes/lines/lines_route.dart';

class LineListTile extends StatelessWidget {
  const LineListTile({
    super.key,
    required this.line,
  });

  final Line line;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        line.id ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        line.name ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        LineRoute(
          id: line.id!,
        ).go(context);
      },
    );
  }
}
