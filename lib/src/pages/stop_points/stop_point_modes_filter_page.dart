import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointModesFilterPage extends StatelessWidget {
  StopPointModesFilterPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final stopPointModesFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).stopPointModes.get();

    return Scaffold(
      appBar: AppBar(
        title: Text('Modes'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Mode>>(
        future: stopPointModesFuture,
        builder: (context, data) {
          return Consumer<StopPointFiltersChangeNotifier>(
            builder: (context, stopPointFiltersChangeNotifier, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final modeName = data[index].modeName;

                  return CheckboxListTile(
                    value:
                        stopPointFiltersChangeNotifier.modes.contains(modeName),
                    onChanged: (value) {
                      if (value) {
                        stopPointFiltersChangeNotifier.addMode(modeName);
                      } else {
                        stopPointFiltersChangeNotifier.removeMode(modeName);
                      }
                    },
                    title: NullableText(
                      modeName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
                itemCount: data.length,
              );
            },
          );
        },
      ),
    );
  }
}
