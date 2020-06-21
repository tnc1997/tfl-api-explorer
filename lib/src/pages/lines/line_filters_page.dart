import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_mode_name_filter_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineFiltersPage extends StatelessWidget {
  LineFiltersPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
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
        builder: (context, lineFiltersChangeNotifier, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Mode name'),
                subtitle: NullableText(
                  lineFiltersChangeNotifier.modeName,
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
