import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'line_list_tile.dart';

class LineListView extends StatelessWidget {
  const LineListView({
    super.key,
    required this.lines,
  });

  final List<Line> lines;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return LineListTile(
          line: lines[index],
        );
      },
      itemCount: lines.length,
    );
  }
}
