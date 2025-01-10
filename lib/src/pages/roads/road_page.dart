import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/circular_progress_indicator_future_builder.dart';

class RoadPage extends StatefulWidget {
  const RoadPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<RoadPage> createState() {
    return _RoadPageState();
  }
}

class _RoadPageState extends State<RoadPage> {
  late final Future<List<RoadCorridor>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RoadCorridor>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(
                    data[0].displayName ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Group'),
                  subtitle: Text(
                    data[0].group ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Status severity'),
                  subtitle: Text(
                    data[0].statusSeverity ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Bounds'),
                  subtitle: Text(
                    data[0].bounds ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (data[0].url case final url?)
                  ListTile(
                    title: Text('URL'),
                    subtitle: Text(
                      url,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () async {
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                  ),
                Divider(),
                ListTile(
                  title: Text('Road disruptions'),
                  onTap: () {
                    context.go('/roads/${widget.id}/road-disruptions');
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

    _future = context.read<TflApiClient>().road.get([widget.id]);
  }
}
