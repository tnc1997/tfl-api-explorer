import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/identifier_list_tile.dart';

class StopPointLinesPage extends StatelessWidget {
  static const routeName = '/stop_points/:id/lines';

  StopPointLinesPage({
    Key? key,
    required this.stopPoint,
  }) : super(
          key: key,
        );

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    final lines = stopPoint.lines;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
      ),
      body: lines != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return IdentifierListTile(
                  identifier: lines[index],
                );
              },
              itemCount: lines.length,
            )
          : Container(),
    );
  }
}
