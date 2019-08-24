import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_prediction_filters_change_notifier.dart';
import '../../widgets/text.dart';

class LinePredictionFiltersPage extends StatefulWidget {
  LinePredictionFiltersPage({Key key}) : super(key: key);

  @override
  _LinePredictionFiltersPageState createState() =>
      _LinePredictionFiltersPageState();
}

class _LinePredictionFiltersPageState
    extends State<LinePredictionFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
      ),
      body: Consumer<LinePredictionFiltersChangeNotifier>(
        builder: (context, linePredictionFilters, child) {
          return ListView(
            children: <Widget>[
              AlignedListTile(
                title: Text('Station name'),
                subtitle: NullableText(
                  linePredictionFilters.stationName,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    linePredictionFilters.stationName = null;
                  },
                ),
              ),
              AlignedListTile(
                title: Text('Destination name'),
                subtitle: NullableText(
                  linePredictionFilters.destinationName,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    linePredictionFilters.destinationName = null;
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
