import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_line_route_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/line_route_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineLineRoutesPage extends StatefulWidget {
  static const routeName = '/lines/:id/line_routes';

  LineLineRoutesPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LineLineRoutesPageState createState() => _LineLineRoutesPageState();
}

class _LineLineRoutesPageState extends State<LineLineRoutesPage> {
  Future<List<LineRoute>> _lineRoutesFuture;

  @override
  Widget build(BuildContext context) {
    final lineLineRouteFiltersChangeNotifier =
        context.watch<LineLineRouteFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.filter),
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
      body: CircularProgressIndicatorFutureBuilder<List<LineRoute>>(
        future: _lineRoutesFuture,
        builder: (context, data) {
          final lineRoutes = data
              .where(lineLineRouteFiltersChangeNotifier.areSatisfiedBy)
              .toList();

          return ListView.builder(
            itemBuilder: (context, index) {
              return LineRouteListTile(
                lineRoute: lineRoutes[index],
              );
            },
            itemCount: lineRoutes.length,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _lineRoutesFuture =
        context.read<TflApi>().lines.getLineRoutes(widget.line.id);
  }
}

class _LineLineRouteFiltersPage extends StatefulWidget {
  @override
  _LineLineRouteFiltersPageState createState() =>
      _LineLineRouteFiltersPageState();
}

class _LineLineRouteFiltersPageState extends State<_LineLineRouteFiltersPage> {
  Future<List<String>> _lineServiceTypesFuture;

  @override
  Widget build(BuildContext context) {
    final lineLineRouteFiltersChangeNotifier =
        context.watch<LineLineRouteFiltersChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.restore),
            onPressed: () {
              lineLineRouteFiltersChangeNotifier.reset();
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List>(
        future: Future.wait([_lineServiceTypesFuture]),
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              ExpansionTile(
                title: Text('Service type'),
                children: (data[0] as List<String>).map((serviceType) {
                  return RadioListTile<String>(
                    value: serviceType,
                    groupValue: lineLineRouteFiltersChangeNotifier.serviceType,
                    onChanged: (value) {
                      lineLineRouteFiltersChangeNotifier.serviceType = value;
                    },
                    title: NullableText(
                      serviceType,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _lineServiceTypesFuture = context.read<TflApi>().lineServiceTypes.get();
  }
}
