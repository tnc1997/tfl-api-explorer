import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/lines_filter_change_notifier.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';

class LinesFilterPage extends StatefulWidget {
  LinesFilterPage({Key key}) : super(key: key);

  @override
  _LinesFilterPageState createState() => _LinesFilterPageState();
}

class _LinesFilterPageState extends State<LinesFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              Provider.of<LinesFilterChangeNotifier>(
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
              return Consumer<LinesFilterChangeNotifier>(
                builder: (context, linesFilter, child) {
                  return ListView(
                    children: <Widget>[
                      ExpansionTile(
                        title: Text('Mode'),
                        children: data.map((mode) {
                          return RadioListTile<String>(
                            value: mode.modeName,
                            groupValue: linesFilter.mode,
                            onChanged: (mode) {
                              linesFilter.mode = mode;
                            },
                            title: NullableText(
                              mode.modeName,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: NullableText(
                              mode.isTflService ? 'Operated by TfL' : '',
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
}
