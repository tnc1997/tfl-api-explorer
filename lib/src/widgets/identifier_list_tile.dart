import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class IdentifierListTile extends StatelessWidget {
  IdentifierListTile({
    Key key,
    @required this.identifier,
  }) : super(
          key: key,
        );

  final Identifier identifier;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        identifier.id,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        identifier.name,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
