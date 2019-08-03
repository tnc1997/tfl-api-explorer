import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              ListTile(
                title: Text('Stop point'),
                subtitle: NullableText(
                  linePredictionsFilters.stopPoint?.commonName,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    linePredictionsFilters.stopPoint = null;
                  },
                ),
              ),
              ListTile(
                title: Text('Destination'),
                subtitle: NullableText(
                  linePredictionsFilters.destination?.commonName,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    linePredictionsFilters.destination = null;
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
