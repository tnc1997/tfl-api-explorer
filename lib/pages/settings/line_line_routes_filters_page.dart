import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notifiers/line_line_routes_filters_change_notifier.dart';
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
        title: Text('Line routes'),
      ),
      body: Consumer<LineLineRoutesFiltersChangeNotifier>(
        builder: (context, lineLineRoutesFilters, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Service types'),
                subtitle: NullableText(
                  lineLineRoutesFilters.serviceTypes?.join(', '),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    lineLineRoutesFilters.clearServiceTypes();
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
