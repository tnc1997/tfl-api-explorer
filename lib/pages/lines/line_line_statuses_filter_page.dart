import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/line_line_statuses_filter_change_notifier.dart';

class LineLineStatusesFilterPage extends StatefulWidget {
  LineLineStatusesFilterPage({Key key}) : super(key: key);

  @override
  _LineLineStatusesFilterPageState createState() =>
      _LineLineStatusesFilterPageState();
}

class _LineLineStatusesFilterPageState
    extends State<LineLineStatusesFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LineLineStatusesFilterChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<LineLineStatusesFilterChangeNotifier>(
        builder: (context, lineLineStatusesFilter, child) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);

          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Date'),
                trailing: Icon(Icons.navigate_next),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: lineLineStatusesFilter.date ?? today,
                    firstDate: today,
                    lastDate: today.add(Duration(days: 30)),
                  );

                  lineLineStatusesFilter.date = date;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
