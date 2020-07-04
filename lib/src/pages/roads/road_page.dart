import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/roads/road_road_disruptions_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
import 'package:url_launcher/url_launcher.dart';

class RoadPage extends StatelessWidget {
  static const routeName = '/roads/:id';

  RoadPage({
    Key key,
    @required this.road,
  }) : super(
          key: key,
        );

  final Road road;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(road.id),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: NullableText(
              road.displayName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Group'),
            subtitle: NullableText(
              road.group,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Status severity'),
            subtitle: NullableText(
              road.statusSeverity,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Bounds'),
            subtitle: NullableText(
              road.bounds,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('URL'),
            subtitle: NullableText(
              road.url,
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
