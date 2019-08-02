import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/line_line_routes_filter_change_notifier.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LineLineRoutesFilterPage extends StatefulWidget {
  LineLineRoutesFilterPage({Key key}) : super(key: key);

  @override
  _LineLineRoutesFilterPageState createState() =>
      _LineLineRoutesFilterPageState();
}

class _LineLineRoutesFilterPageState extends State<LineLineRoutesFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LineLineRoutesFilterChangeNotifier>(
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
              return Consumer<LineLineRoutesFilterChangeNotifier>(
                builder: (context, lineLineRoutesFilter, child) {
                  return ListView(
                    children: <Widget>[
                      ExpansionTile(
                        title: Text('Service Types'),
                        children: data.map((serviceType) {
                          return CheckboxListTile(
                            value: lineLineRoutesFilter.serviceTypes
                                .contains(serviceType),
                            onChanged: (isChecked) {
                              isChecked
                                  ? lineLineRoutesFilter
                                      .addServiceType(serviceType)
                                  : lineLineRoutesFilter
                                      .removeServiceType(serviceType);
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
          );
        },
      ),
    );
  }
}
