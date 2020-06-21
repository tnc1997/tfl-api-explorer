import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_explorer/src/notifiers/stop_point_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_modes_filter_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointFiltersPage extends StatelessWidget {
  StopPointFiltersPage({
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
              Provider.of<StopPointFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<StopPointFiltersChangeNotifier>(
        builder: (context, stopPointFiltersChangeNotifier, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Modes'),
                subtitle: NullableText(
                  stopPointFiltersChangeNotifier.modes.join(', '),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return StopPointModesFilterPage();
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
