import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'stop_point_additional_properties_route.dart';
import 'stop_point_lines_route.dart';
import 'stop_point_modes_route.dart';
import 'stop_points_route.dart';

class StopPointScreen extends StatefulWidget {
  const StopPointScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<StopPointScreen> createState() {
    return _StopPointScreenState();
  }
}

class _StopPointScreenState extends State<StopPointScreen> {
  late final Future<List<StopPoint>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop point'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _future,
        builder: (context, data) {
          if (data?[0] case final stopPoint?) {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(
                    stopPoint.commonName ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('ICS code'),
                  subtitle: Text(
                    stopPoint.icsCode ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('SMS code'),
                  subtitle: Text(
                    stopPoint.smsCode ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Stop type'),
                  subtitle: Text(
                    stopPoint.stopType ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Accessibility'),
                  subtitle: Text(
                    stopPoint.accessibilitySummary ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Hub NaPTAN code'),
                  subtitle: Text(
                    stopPoint.hubNaptanCode ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (stopPoint.url case final url?)
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
                ListTile(
                  title: Text('Place type'),
                  subtitle: Text(
                    stopPoint.placeType ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Lat'),
                  subtitle: Text(
                    stopPoint.lat?.toString() ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Lon'),
                  subtitle: Text(
                    stopPoint.lon?.toString() ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Additional properties'),
                  onTap: () {
                    StopPointAdditionalPropertiesRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
                ListTile(
                  title: Text('Modes'),
                  onTap: () {
                    StopPointModesRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
                ListTile(
                  title: Text('Lines'),
                  onTap: () {
                    StopPointLinesRoute(
                      id: widget.id,
                    ).go(context);
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

    _future = context.read<TflApiClient>().stopPoint.get([widget.id]);
  }
}
