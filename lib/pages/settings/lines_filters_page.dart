import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/list_tile.dart';
import '../../notifiers/lines_filters_change_notifier.dart';
import '../../widgets/text.dart';
import 'line_line_routes_filters_page.dart';
import 'line_predictions_filters_page.dart';

class LinesFiltersPage extends StatefulWidget {
  LinesFiltersPage({Key key}) : super(key: key);

  @override
  _LinesFiltersPageState createState() => _LinesFiltersPageState();
}

class _LinesFiltersPageState extends State<LinesFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
      ),
      body: Consumer<LinesFiltersChangeNotifier>(
        builder: (context, linesFilters, child) {
          return ListView(
            children: <Widget>[
              AlignedListTile(
                title: Text('Mode name'),
                subtitle: NullableText(
                  linesFilters.modeName,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    linesFilters.modeName = null;
                  },
                ),
              ),
              Divider(),
              AlignedListTile(
                title: Text('Line routes'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return LineLineRoutesFiltersPage();
                    }),
                  );
                },
              ),
              AlignedListTile(
                title: Text('Predictions'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return LinePredictionsFiltersPage();
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
