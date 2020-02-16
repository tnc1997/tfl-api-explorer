import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_lines_page.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_modes_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
import 'package:url_launcher/url_launcher.dart';

class StopPointPage extends StatelessWidget {
  static const routeName = '/stop_points/:id';

  StopPointPage({
    Key key,
    @required this.stopPoint,
  }) : super(
          key: key,
        );

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stopPoint.id),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Name'),
            subtitle: NullableText(
              stopPoint.commonName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('ICS code'),
            subtitle: NullableText(
              stopPoint.icsCode,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('SMS code'),
            subtitle: NullableText(
              stopPoint.smsCode,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Stop type'),
            subtitle: NullableText(
              stopPoint.stopType,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Accessibility'),
            subtitle: NullableText(
              stopPoint.accessibilitySummary,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Hub NaPTAN code'),
            subtitle: NullableText(
              stopPoint.hubNaptanCode,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('URL'),
            subtitle: NullableText(
              stopPoint.url,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: stopPoint.url != null
                ? () async {
                    await launch(stopPoint.url);
                  }
                : null,
          ),
          ListTile(
            title: Text('Place type'),
            subtitle: NullableText(
              stopPoint.placeType,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lat'),
            subtitle: NullableText(
              stopPoint.lat?.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lon'),
            subtitle: NullableText(
              stopPoint.lon?.toString(),
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
