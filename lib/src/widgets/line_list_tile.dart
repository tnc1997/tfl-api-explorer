import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineListTile extends StatelessWidget {
  LineListTile({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        line.id,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        line.name,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          LinePage.routeName,
          arguments: line,
        );
      },
    );
  }
}
