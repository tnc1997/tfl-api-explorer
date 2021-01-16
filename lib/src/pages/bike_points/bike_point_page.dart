import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_additional_properties_page.dart';

class BikePointPage extends StatelessWidget {
  static const routeName = '/bike_points/:id';

  BikePointPage({
    Key? key,
    required this.bikePoint,
  }) : super(
          key: key,
        );

  final Place bikePoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bikePoint.id ?? 'Unknown'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: Text(
              bikePoint.commonName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Place type'),
            subtitle: Text(
              bikePoint.placeType ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lat'),
            subtitle: Text(
              bikePoint.lat?.toString() ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lon'),
            subtitle: Text(
              bikePoint.lon?.toString() ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Additional properties'),
            onTap: () {
              Navigator.of(context).pushNamed(
                BikePointAdditionalPropertiesPage.routeName,
                arguments: bikePoint,
              );
            },
          ),
        ],
      ),
    );
  }
}
