import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointModesPage extends StatelessWidget {
  static const routeName = '/stop_points/:id/modes';

  StopPointModesPage({
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
        title: Text('Modes'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: NullableText(
              stopPoint.modes[index],
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        itemCount: stopPoint.modes.length,
      ),
    );
  }
}
