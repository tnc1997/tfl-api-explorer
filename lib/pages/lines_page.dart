import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/drawer.dart';
import '../widgets/text.dart';

class LinesPage extends StatefulWidget {
  static const route = '/lines';

  LinesPage({Key key}) : super(key: key);

  @override
  _LinesPageState createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, value, child) {
          return CircularProgressIndicatorFutureBuilder<List<Line>>(
            future: value.tflApi.lines.get(),
            builder: (context, data) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: NullableText(
                      data[index].id,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: NullableText(
                      data[index].name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
