import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'line_line_route_filters_notifier.dart';
import 'line_route_list_tile.dart';

class LineLineRoutesScreen extends StatefulWidget {
  const LineLineRoutesScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LineLineRoutesScreen> createState() {
    return _LineLineRoutesScreenState();
  }
}

class _LineLineRoutesScreenState extends State<LineLineRoutesScreen> {
  late final Future<List<Line>> _future;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LineLineRouteFiltersNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return _LineLineRouteFiltersPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _future,
        builder: (context, data) {
          final lineRoutes = data
              ?.fold(
                <MatchedRoute>[],
                (previousValue, element) {
                  return previousValue..addAll(element.routeSections ?? []);
                },
              )
              .where(notifier.areSatisfiedBy)
              .toList();

          if (lineRoutes != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return LineRouteListTile(
                  lineRoute: lineRoutes[index],
                );
              },
              itemCount: lineRoutes.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _future = context.read<TflApiClient>().line.lineRoutesByIds([widget.id]);
  }
}

class _LineLineRouteFiltersPage extends StatefulWidget {
  @override
  State<_LineLineRouteFiltersPage> createState() {
    return _LineLineRouteFiltersPageState();
  }
}

class _LineLineRouteFiltersPageState extends State<_LineLineRouteFiltersPage> {
  late final Future<List<String>> _future;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LineLineRouteFiltersNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              notifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_future]),
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Service type'),
                  children: (data[0] as List<String>).map((serviceType) {
                    return RadioListTile<String>(
                      value: serviceType,
                      groupValue: notifier.serviceType,
                      onChanged: (value) {
                        notifier.serviceType = value;
                      },
                      title: Text(
                        serviceType,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _future = context.read<TflApiClient>().line.metaServiceTypes();
  }
}
