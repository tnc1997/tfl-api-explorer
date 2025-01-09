import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

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
        context.go('/lines/${line.id}');
      },
    );
  }
}
