import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_route_list_tile.dart';

class LineLineRoutesPage extends StatefulWidget {
  static const routeName = '/lines/:id/line_routes';

  const LineLineRoutesPage({
    super.key,
    required this.line,
  });

  final Line line;

  @override
  State<LineLineRoutesPage> createState() {
    return _LineLineRoutesPageState();
  }
}

class _LineLineRoutesPageState extends State<LineLineRoutesPage> {
  late Future<List<MatchedRoute>> _lineRoutesFuture;

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
      body: CircularProgressIndicatorFutureBuilder<List<MatchedRoute>>(
        future: _lineRoutesFuture,
        builder: (context, data) {
          final lineRoutes = data
              ?.where(lineLineRouteFiltersChangeNotifier.areSatisfiedBy)
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

    _lineRoutesFuture = context
        .read<TflApiClient>()
        .line
        .lineRoutesByIds([widget.line.id!]).then((value) => value
            .fold<List<MatchedRoute>>(
                [],
                (previousValue, element) =>
                    previousValue..addAll(element.routeSections ?? [])));
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
