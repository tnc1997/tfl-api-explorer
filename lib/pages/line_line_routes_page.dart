import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../notifiers/line_line_routes_filter_change_notifier.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import '../widgets/text.dart';
import 'line_line_routes_filter_page.dart';

class LineLineRoutesPage extends StatefulWidget {
  static const route = '/lines/:id/line_routes';

  final String id;

  LineLineRoutesPage({Key key, @required this.id}) : super(key: key);

  @override
  _LineLineRoutesPageState createState() => _LineLineRoutesPageState();
}

class _LineLineRoutesPageState extends State<LineLineRoutesPage> {
  StreamController<List<LineRoute>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LineLineRoutesFilterPage();
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          return Consumer<LineLineRoutesFilterChangeNotifier>(
            builder: (context, lineLineRoutesFilter, child) {
              final getLineRoutes = () {
                return tflApi.tflApi.lines.getLineRoutes(
                  widget.id,
                  serviceTypes: lineLineRoutesFilter.serviceTypes,
                );
              };

              getLineRoutes()
                  .then(_streamController.add)
                  .catchError(_streamController.addError);

              return CircularProgressIndicatorStreamBuilder<List<LineRoute>>(
                stream: _streamController.stream,
                builder: (context, data) {
                  return RefreshIndicator(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: NullableText(
                            data[index].name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Origination'),
                              subtitle: NullableText(
                                data[index].originationName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ListTile(
                              title: Text('Destination'),
                              subtitle: NullableText(
                                data[index].destinationName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ListTile(
                              title: Text('Service type'),
                              subtitle: NullableText(
                                data[index].serviceType,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ListTile(
                              title: Text('Valid to'),
                              subtitle: NullableText(
                                data[index].validTo?.toIso8601String(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ListTile(
                              title: Text('Valid from'),
                              subtitle: NullableText(
                                data[index].validFrom?.toIso8601String(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: data.length,
                    ),
                    onRefresh: () {
                      return getLineRoutes()
                          .then(_streamController.add)
                          .catchError(_streamController.addError);
                    },
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
  void dispose() {
    super.dispose();

    _streamController.close();
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<List<LineRoute>>();
  }
}
