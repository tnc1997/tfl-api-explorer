import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../widgets/circular_progress_indicator_future_builder.dart';

class LinePage extends StatefulWidget {
  const LinePage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LinePage> createState() {
    return _LinePageState();
  }
}

class _LinePageState extends State<LinePage> {
  late final Future<List<Line>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(
                    data[0].name ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Mode name'),
                  subtitle: Text(
                    data[0].modeName ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Line disruptions'),
                  onTap: () {
                    context.go('/lines/${widget.id}/line-disruptions');
                  },
                ),
                ListTile(
                  title: Text('Line routes'),
                  onTap: () {
                    context.go('/lines/${widget.id}/line-routes');
                  },
                ),
                ListTile(
                  title: Text('Line statuses'),
                  onTap: () {
                    context.go('/lines/${widget.id}/line-statuses');
                  },
                ),
                ListTile(
                  title: Text('Predictions'),
                  onTap: () {
                    context.go('/lines/${widget.id}/predictions');
                  },
                ),
                ListTile(
                  title: Text('Route sequences'),
                  onTap: () {
                    context.go('/lines/${widget.id}/route-sequences');
                  },
                ),
                ListTile(
                  title: Text('Stop points'),
                  onTap: () {
                    context.go('/lines/${widget.id}/stop-points');
                  },
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

    _future = context.read<TflApiClient>().line.get([widget.id]);
  }
}
