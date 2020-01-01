import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/async.dart';
import 'package:tfl_api_explorer/src/widgets/text.dart';

class LineLineRouteServiceTypeFilterPage extends StatefulWidget {
  LineLineRouteServiceTypeFilterPage({Key key}) : super(key: key);

  @override
  _LineLineRouteServiceTypeFilterPageState createState() =>
      _LineLineRouteServiceTypeFilterPageState();
}

class _LineLineRouteServiceTypeFilterPageState
    extends State<LineLineRouteServiceTypeFilterPage> {
  Future<List<String>> _lineServiceTypesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service type'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<String>>(
        future: _lineServiceTypesFuture,
        builder: (context, data) {
          return Consumer<LineLineRouteFiltersChangeNotifier>(
            builder: (context, lineLineRouteFilters, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    value: data[index],
                    groupValue: lineLineRouteFilters.serviceType,
                    onChanged: (value) {
                      lineLineRouteFilters.serviceType = value;
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

  @override
  void initState() {
    super.initState();

    _lineServiceTypesFuture = Provider.of<TflApiState>(
      context,
      listen: false,
    ).tflApi.lineServiceTypes.get();
  }
}
