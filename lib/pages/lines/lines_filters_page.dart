import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/widgets/text.dart';

import '../../notifiers/lines_filters_change_notifier.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';

class LinesFiltersPage extends StatefulWidget {
  LinesFiltersPage({Key key}) : super(key: key);

  @override
  _LinesFiltersPageState createState() => _LinesFiltersPageState();
}

class _LinesFiltersPageState extends State<LinesFiltersPage> {
  Future<List<Mode>> _lineModesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Consumer<TflApiState>(
        builder: (context, tflApi, child) {
          return CircularProgressIndicatorFutureBuilder<List<Mode>>(
            future: _lineModesFuture,
            builder: (context, data) {
              return Consumer<LinesFiltersChangeNotifier>(
                builder: (context, linesFilters, child) {
                  return ListView(
                    children: <Widget>[
                      ExpansionTile(
                        leading: SizedBox(),
                        title: Text('Mode name'),
                        children: data.map((mode) {
                          return RadioListTile<String>(
                            value: mode.modeName,
                            groupValue: linesFilters.modeName,
                            onChanged: (value) {
                              linesFilters.modeName = value;
                            },
                            title: NullableText(
                              mode.modeName,
                              overflow: TextOverflow.ellipsis,
                            ),
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

  @override
  void initState() {
    super.initState();

    final tflApi = Provider.of<TflApiState>(context, listen: false);
    _lineModesFuture = tflApi.tflApi.lineModes.get();
  }
}
