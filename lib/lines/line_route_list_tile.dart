import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'line_route_page.dart';

class LineRouteListTile extends StatelessWidget {
  const LineRouteListTile({
    super.key,
    required this.lineRoute,
  });

  final MatchedRoute lineRoute;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        lineRoute.name ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        lineRoute.serviceType ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return LineRoutePage(
                lineRoute: lineRoute,
              );
            },
          ),
        );
      },
    );
  }
}
