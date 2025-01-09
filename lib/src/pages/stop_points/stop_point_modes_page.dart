import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../widgets/circular_progress_indicator_future_builder.dart';

class StopPointModesPage extends StatefulWidget {
  const StopPointModesPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<StopPointModesPage> createState() {
    return _StopPointModesPageState();
  }
}

class _StopPointModesPageState extends State<StopPointModesPage> {
  late final Future<List<StopPoint>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modes'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _future,
        builder: (context, data) {
          if (data?[0].modes case final modes?) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    modes[index],
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              itemCount: modes.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _future = context.read<TflApiClient>().stopPoint.get([widget.id]);
  }
}
