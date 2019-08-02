import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/notifiers/line_line_routes_filter_change_notifier.dart';
import 'package:tfl_api_explorer/notifiers/line_line_statuses_filter_change_notifier.dart';
import 'package:tfl_api_explorer/notifiers/line_predictions_filter_change_notifier.dart';

import '../widgets/text.dart';

class SettingsFiltersPage extends StatefulWidget {
  SettingsFiltersPage({Key key}) : super(key: key);

  @override
  _SettingsFiltersPageState createState() => _SettingsFiltersPageState();
}

class _SettingsFiltersPageState extends State<SettingsFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text('Lines'),
            children: <Widget>[
              Consumer<LineLineRoutesFilterChangeNotifier>(
                builder: (context, lineLineRoutesFilter, child) {
                  return ExpansionTile(
                    title: Text('Line Routes'),
                    children: <Widget>[
                      ListTile(
                        title: Text('Service Types'),
                        subtitle: NullableText(
                          lineLineRoutesFilter.serviceTypes.join(', '),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.restore),
                          onPressed: () {
                            lineLineRoutesFilter.clearServiceTypes();
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              Consumer<LineLineStatusesFilterChangeNotifier>(
                builder: (context, lineLineStatusesFilter, child) {
                  return ExpansionTile(
                    title: Text('Line Statuses'),
                    children: <Widget>[
                      ListTile(
                        title: Text('Date'),
                        subtitle: NullableText(
                          lineLineStatusesFilter.date?.toIso8601String(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.restore),
                          onPressed: () {
                            lineLineStatusesFilter.date = null;
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              Consumer<LinePredictionsFilterChangeNotifier>(
                builder: (context, lineLineStatusesFilter, child) {
                  return ExpansionTile(
                    title: Text('Predictions'),
                    children: <Widget>[
                      ListTile(
                        title: Text('Stop Point'),
                        subtitle: NullableText(
                          lineLineStatusesFilter.stopPoint,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.restore),
                          onPressed: () {
                            lineLineStatusesFilter.stopPoint = null;
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Destination'),
                        subtitle: NullableText(
                          lineLineStatusesFilter.destination,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.restore),
                          onPressed: () {
                            lineLineStatusesFilter.destination = null;
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
