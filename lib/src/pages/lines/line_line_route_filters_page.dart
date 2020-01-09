import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_route_service_type_filter_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineLineRouteFiltersPage extends StatelessWidget {
  LineLineRouteFiltersPage({
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
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LineLineRouteFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<LineLineRouteFiltersChangeNotifier>(
        builder: (context, lineLineRouteFiltersChangeNotifier, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Service type'),
                subtitle: NullableText(
                  lineLineRouteFiltersChangeNotifier.serviceType,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LineLineRouteServiceTypeFilterPage();
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
