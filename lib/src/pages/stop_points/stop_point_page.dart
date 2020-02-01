import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointPage extends StatelessWidget {
  static const routeName = '/stop_points/:id';

  StopPointPage({
    Key key,
    @required this.stopPoint,
  }) : super(
          key: key,
        );

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stopPoint.id),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Name'),
            subtitle: NullableText(
              stopPoint.commonName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
