import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class StopPointModesPage extends StatelessWidget {
  static const routeName = '/stop_points/:id/modes';

  const StopPointModesPage({
    super.key,
    required this.stopPoint,
  });

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    final modes = stopPoint.modes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Modes'),
      ),
      body: modes != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    modes[index],
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              itemCount: modes.length,
            )
          : Container(),
    );
  }
}
