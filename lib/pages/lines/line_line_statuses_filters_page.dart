import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_line_statuses_filters_change_notifier.dart';

class LineLineStatusesFiltersPage extends StatefulWidget {
  LineLineStatusesFiltersPage({Key key}) : super(key: key);

  @override
  _LineLineStatusesFiltersPageState createState() =>
      _LineLineStatusesFiltersPageState();
}

class _LineLineStatusesFiltersPageState
    extends State<LineLineStatusesFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LineLineStatusesFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<LineLineStatusesFiltersChangeNotifier>(
        builder: (context, lineLineStatusesFilters, child) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);

          return ListView(
            children: <Widget>[
              AlignedListTile(
                title: Text('Date'),
                trailing: Icon(Icons.navigate_next),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: lineLineStatusesFilters.date ?? today,
                    firstDate: today,
                    lastDate: today.add(Duration(days: 30)),
                  );

                  lineLineStatusesFilters.date = date;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
