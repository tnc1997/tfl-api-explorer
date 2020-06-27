import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class BayListTile extends StatelessWidget {
  BayListTile({
    Key key,
    @required this.bay,
  }) : super(
          key: key,
        );

  final Bay bay;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        bay.bayType,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        '${bay.occupied} / ${bay.bayCount}',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: CircularProgressIndicator(
        value: bay.occupied / bay.bayCount,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}
