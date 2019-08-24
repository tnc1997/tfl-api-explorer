import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/line_line_route_filters_change_notifier.dart';
import '../../widgets/text.dart';

class LineLineRouteFiltersPage extends StatefulWidget {
  LineLineRouteFiltersPage({Key key}) : super(key: key);

  @override
  _LineLineRouteFiltersPageState createState() =>
      _LineLineRouteFiltersPageState();
}

class _LineLineRouteFiltersPageState extends State<LineLineRouteFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
      ),
      body: Consumer<LineLineRouteFiltersChangeNotifier>(
        builder: (context, lineLineRouteFilters, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Service type'),
                subtitle: NullableText(
                  lineLineRouteFilters.serviceType,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    lineLineRouteFilters.serviceType = null;
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
