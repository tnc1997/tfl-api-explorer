import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_predictions_filters_change_notifier.dart';
import '../../widgets/text.dart';

class LinePredictionsFiltersPage extends StatefulWidget {
  LinePredictionsFiltersPage({Key key}) : super(key: key);

  @override
  _LinePredictionsFiltersPageState createState() =>
      _LinePredictionsFiltersPageState();
}

class _LinePredictionsFiltersPageState
    extends State<LinePredictionsFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
      ),
      body: Consumer<LinePredictionsFiltersChangeNotifier>(
        builder: (context, linePredictionsFilters, child) {
          return ListView(
            children: <Widget>[
              AlignedListTile(
                title: Text('Station name'),
                subtitle: NullableText(
                  linePredictionsFilters.stationName,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    linePredictionsFilters.stationName = null;
                  },
                ),
              ),
              AlignedListTile(
                title: Text('Destination name'),
                subtitle: NullableText(
                  linePredictionsFilters.destinationName,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    linePredictionsFilters.destinationName = null;
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
