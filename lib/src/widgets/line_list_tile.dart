import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../pages/lines/line_page.dart';

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
        Navigator.of(context).pushNamed(
          LinePage.routeName,
          arguments: line.id,
        );
      },
    );
  }
}
