import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:url_launcher/url_launcher.dart';

import 'stop_point_additional_properties_page.dart';
import 'stop_point_lines_page.dart';
import 'stop_point_modes_page.dart';

class StopPointPage extends StatelessWidget {
  static const routeName = '/stop_points/:id';

  const StopPointPage({
    super.key,
    required this.stopPoint,
  });

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    final url = stopPoint.url;

    return Scaffold(
      appBar: AppBar(
        title: Text(stopPoint.id ?? 'Unknown'),
      ),
      body: ListView(
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
          ListTile(
            title: Text('URL'),
            subtitle: Text(
              url ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: url != null
                ? () async {
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
                  }
                : null,
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
                arguments: stopPoint,
              );
            },
          ),
          ListTile(
            title: Text('Modes'),
            onTap: () {
              Navigator.of(context).pushNamed(
                StopPointModesPage.routeName,
                arguments: stopPoint,
              );
            },
          ),
          ListTile(
            title: Text('Lines'),
            onTap: () {
              Navigator.of(context).pushNamed(
                StopPointLinesPage.routeName,
                arguments: stopPoint,
              );
            },
          ),
        ],
      ),
    );
  }
}
