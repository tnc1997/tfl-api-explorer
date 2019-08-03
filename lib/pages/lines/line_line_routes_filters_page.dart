import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/line_line_routes_filters_change_notifier.dart';
import '../../notifiers/tfl_api_change_notifier.dart';
import '../../widgets/async.dart';
import '../../widgets/text.dart';

class LineLineRoutesFiltersPage extends StatefulWidget {
  LineLineRoutesFiltersPage({Key key}) : super(key: key);

  @override
  _LineLineRoutesFiltersPageState createState() =>
      _LineLineRoutesFiltersPageState();
}

class _LineLineRoutesFiltersPageState extends State<LineLineRoutesFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LineLineRoutesFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          return CircularProgressIndicatorFutureBuilder<List<String>>(
            future: tflApi.tflApi.lineServiceTypes.get(),
            builder: (context, data) {
              return Consumer<LineLineRoutesFiltersChangeNotifier>(
                builder: (context, lineLineRoutesFilters, child) {
                  return ListView(
                    children: <Widget>[
                      ExpansionTile(
                        leading: SizedBox(),
                        title: Text('Service types'),
                        children: data.map((serviceType) {
                          return CheckboxListTile(
                            value: lineLineRoutesFilters.serviceTypes
                                .contains(serviceType),
                            onChanged: (isChecked) {
                              isChecked
                                  ? lineLineRoutesFilters
                                      .addServiceType(serviceType)
                                  : lineLineRoutesFilters
                                      .removeServiceType(serviceType);
                            },
                            title: NullableText(
                              serviceType,
                              overflow: TextOverflow.ellipsis,
                            ),
                            secondary: SizedBox(),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
