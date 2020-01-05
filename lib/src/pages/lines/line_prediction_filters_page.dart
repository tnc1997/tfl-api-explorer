import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_prediction_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_prediction_destination_name_filter_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_prediction_station_name_filter_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LinePredictionFiltersPage extends StatefulWidget {
  final Line line;

  LinePredictionFiltersPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  @override
  _LinePredictionFiltersPageState createState() =>
      _LinePredictionFiltersPageState();
}

class _LinePredictionFiltersPageState extends State<LinePredictionFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
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
        builder: (context, linePredictionFilters, child) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Station name'),
                subtitle: NullableText(
                  linePredictionFilters.stationName,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LinePredictionStationNameFilterPage(
                          line: widget.line,
                        );
                      },
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Destination name'),
                subtitle: NullableText(
                  linePredictionFilters.destinationName,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LinePredictionDestinationNameFilterPage(
                          line: widget.line,
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
