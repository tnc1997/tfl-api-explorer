import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/line_line_routes_filters_change_notifier.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/text.dart';

class LineLineRoutesFiltersPage extends StatefulWidget {
  LineLineRoutesFiltersPage({Key key}) : super(key: key);

  @override
  _LineLineRoutesFiltersPageState createState() =>
      _LineLineRoutesFiltersPageState();
}

class _LineLineRoutesFiltersPageState extends State<LineLineRoutesFiltersPage> {
  Future<List<String>> _lineServiceTypesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<String>>(
        future: _lineServiceTypesFuture,
        builder: (context, data) {
          return Consumer<LineLineRoutesFiltersChangeNotifier>(
            builder: (context, lineLineRoutesFilters, child) {
              return ListView(
                children: <Widget>[
                  ExpansionTile(
                    leading: SizedBox(),
                    title: Text('Service type'),
                    children: data.map((serviceType) {
                      return RadioListTile<String>(
                        value: serviceType,
                        groupValue: lineLineRoutesFilters.serviceType,
                        onChanged: (value) {
                          lineLineRoutesFilters.serviceType = value;
                        },
                        title: NullableText(
                          serviceType,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                ],
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

    final tflApi = Provider.of<TflApiState>(
      context,
      listen: false,
    );
    _lineServiceTypesFuture = tflApi.tflApi.lineServiceTypes.get();
  }
}
