import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_line_statuses_filters_change_notifier.dart';
import '../../widgets/text.dart';

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
        title: Text('Line statuses'),
      ),
      body: Consumer<LineLineStatusesFiltersChangeNotifier>(
        builder: (context, lineLineStatusesFilters, child) {
          return ListView(
            children: <Widget>[
              AlignedListTile(
                title: Text('Date'),
                subtitle: DateTimeNullableText(
                  lineLineStatusesFilters.date,
                  overflow: TextOverflow.ellipsis,
                  dateFormat: DateFormat.yMMMd(),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    lineLineStatusesFilters.date = null;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
