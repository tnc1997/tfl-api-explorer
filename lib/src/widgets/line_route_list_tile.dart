import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/line_routes/line_route_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineRouteListTile extends StatelessWidget {
  LineRouteListTile({
    Key key,
    @required this.lineRoute,
  }) : super(
          key: key,
        );

  final LineRoute lineRoute;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        lineRoute.name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        lineRoute.serviceType,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          LineRoutePage.route,
          arguments: lineRoute,
        );
      },
    );
  }
}
