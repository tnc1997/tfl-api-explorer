import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/line_filters_change_notifier.dart';
import '../../widgets/text.dart';
import 'line_line_route_filters_page.dart';
import 'line_prediction_filters_page.dart';

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
        title: Text('Lines'),
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
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    lineFilters.modeName = null;
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Line routes'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return LineLineRouteFiltersPage();
                    }),
                  );
                },
              ),
              ListTile(
                title: Text('Predictions'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return LinePredictionFiltersPage();
                    }),
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
