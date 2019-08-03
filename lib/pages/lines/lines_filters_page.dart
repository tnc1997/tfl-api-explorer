import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/radio_list_tile.dart';
import '../../notifiers/lines_filters_change_notifier.dart';
import '../../notifiers/tfl_api_change_notifier.dart';
import '../../widgets/async.dart';

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
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LinesFiltersChangeNotifier>(
                context,
                listen: false,
              ).reset();
            },
          ),
        ],
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          return CircularProgressIndicatorFutureBuilder<List<Mode>>(
            future: tflApi.tflApi.lineModes.get(),
            builder: (context, data) {
              return Consumer<LinesFiltersChangeNotifier>(
                builder: (context, linesFilters, child) {
                  return ListView(
                    children: <Widget>[
                      ExpansionTile(
                        title: Text('Mode'),
                        children: data.map((mode) {
                          return ModeRadioListTile(
                            value: mode,
                            groupValue: linesFilters.mode,
                            onChanged: (mode) {
                              linesFilters.mode = mode;
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
