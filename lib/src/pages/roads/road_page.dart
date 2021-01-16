import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/roads/road_road_disruptions_page.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadPage extends StatelessWidget {
  static const routeName = '/roads/:id';

  RoadPage({
    Key? key,
    required this.road,
  }) : super(
          key: key,
        );

  final RoadCorridor road;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(road.id ?? 'Unknown'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: Text(
              road.displayName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Group'),
            subtitle: Text(
              road.group ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Status severity'),
            subtitle: Text(
              road.statusSeverity ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Bounds'),
            subtitle: Text(
              road.bounds ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('URL'),
            subtitle: Text(
              road.url ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: road.url != null
                ? () async {
                    if (await canLaunch(road.url)) {
                      await launch(road.url);
                    }
                  }
                : null,
          ),
          Divider(),
          ListTile(
            title: Text('Road disruptions'),
            onTap: () {
              Navigator.of(context).pushNamed(
                RoadRoadDisruptionsPage.routeName,
                arguments: road,
              );
            },
          ),
        ],
      ),
    );
  }
}
