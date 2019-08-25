import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/line_filters_change_notifier.dart';
import '../../widgets/text.dart';
import 'line_mode_name_filter_page.dart';

class LineFiltersPage extends StatefulWidget {
  LineFiltersPage({Key key}) : super(key: key);

  @override
  _LineFiltersPageState createState() => _LineFiltersPageState();
}

class _LineFiltersPageState extends State<LineFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LineFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<LineFiltersChangeNotifier>(
        builder: (context, lineFilters, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Mode name'),
                subtitle: NullableText(
                  lineFilters.modeName,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LineModeNameFilterPage();
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
