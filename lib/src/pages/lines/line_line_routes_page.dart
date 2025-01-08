import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../notifiers/line_line_route_filters_change_notifier.dart';
import '../../widgets/circular_progress_indicator_future_builder.dart';
import '../../widgets/line_route_list_tile.dart';

class LineLineRoutesPage extends StatefulWidget {
  static const routeName = '/lines/:id/line_routes';

  const LineLineRoutesPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LineLineRoutesPage> createState() {
    return _LineLineRoutesPageState();
  }
}

class _LineLineRoutesPageState extends State<LineLineRoutesPage> {
  late final Future<List<Line>> _future;

  @override
  Widget build(BuildContext context) {
    final lineLineRouteFiltersChangeNotifier =
        context.watch<LineLineRouteFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              Navigator.of(context).push(
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
              .where(lineLineRouteFiltersChangeNotifier.areSatisfiedBy)
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
  late Future<List<String>> _lineServiceTypesFuture;

  @override
  Widget build(BuildContext context) {
    final lineLineRouteFiltersChangeNotifier =
        context.watch<LineLineRouteFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              lineLineRouteFiltersChangeNotifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_lineServiceTypesFuture]),
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ExpansionTile(
                  title: Text('Service type'),
                  children: (data[0] as List<String>).map((serviceType) {
                    return RadioListTile<String>(
                      value: serviceType,
                      groupValue:
                          lineLineRouteFiltersChangeNotifier.serviceType,
                      onChanged: (value) {
                        lineLineRouteFiltersChangeNotifier.serviceType = value;
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

    _lineServiceTypesFuture =
        context.read<TflApiClient>().line.metaServiceTypes();
  }
}
