import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/circular_progress_indicator_future_builder.dart';
import 'stop_point_additional_properties_page.dart';
import 'stop_point_lines_page.dart';
import 'stop_point_modes_page.dart';

class StopPointPage extends StatefulWidget {
  static const routeName = '/stop_points/:id';

  const StopPointPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<StopPointPage> createState() {
    return _StopPointPageState();
  }
}

class _StopPointPageState extends State<StopPointPage> {
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
                    Navigator.of(context).pushNamed(
                      StopPointAdditionalPropertiesPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
                ListTile(
                  title: Text('Modes'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      StopPointModesPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
                ListTile(
                  title: Text('Lines'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      StopPointLinesPage.routeName,
                      arguments: widget.id,
                    );
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
