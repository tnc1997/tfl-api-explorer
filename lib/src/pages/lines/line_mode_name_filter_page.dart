import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineModeNameFilterPage extends StatelessWidget {
  LineModeNameFilterPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final lineModesFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lineModes.get();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mode name'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Mode>>(
        future: lineModesFuture,
        builder: (context, data) {
          return Consumer<LineFiltersChangeNotifier>(
            builder: (context, lineFiltersChangeNotifier, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    value: data[index].modeName,
                    groupValue: lineFiltersChangeNotifier.modeName,
                    onChanged: (value) {
                      lineFiltersChangeNotifier.modeName = value;
                    },
                    title: NullableText(
                      data[index].modeName,
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
