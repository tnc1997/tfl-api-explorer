import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineLineRouteServiceTypeFilterPage extends StatelessWidget {
  LineLineRouteServiceTypeFilterPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final lineServiceTypesFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lineServiceTypes.get();

    return Scaffold(
      appBar: AppBar(
        title: Text('Service type'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<String>>(
        future: lineServiceTypesFuture,
        builder: (context, data) {
          return Consumer<LineLineRouteFiltersChangeNotifier>(
            builder: (context, lineLineRouteFiltersChangeNotifier, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    value: data[index],
                    groupValue: lineLineRouteFiltersChangeNotifier.serviceType,
                    onChanged: (value) {
                      lineLineRouteFiltersChangeNotifier.serviceType = value;
                    },
                    title: NullableText(
                      data[index],
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
