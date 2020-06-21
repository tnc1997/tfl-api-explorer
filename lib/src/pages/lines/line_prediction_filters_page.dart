import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_prediction_destination_name_filter_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_prediction_station_name_filter_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LinePredictionFiltersPage extends StatelessWidget {
  LinePredictionFiltersPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
            onPressed: () {
              Provider.of<LinePredictionFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<LinePredictionFiltersChangeNotifier>(
        builder: (context, linePredictionFiltersChangeNotifier, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Station name'),
                subtitle: NullableText(
                  linePredictionFiltersChangeNotifier.stationName,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LinePredictionStationNameFilterPage(
                          line: line,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Destination name'),
                subtitle: NullableText(
                  linePredictionFiltersChangeNotifier.destinationName,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LinePredictionDestinationNameFilterPage(
                          line: line,
                        );
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
