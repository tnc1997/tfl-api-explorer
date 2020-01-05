import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_additional_properties_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class BikePointPage extends StatefulWidget {
  static const route = '/bike_points/:id';

  final Place bikePoint;

  BikePointPage({
    Key key,
    @required this.bikePoint,
  }) : super(
          key: key,
        );

  @override
  _BikePointPageState createState() => _BikePointPageState();
}

class _BikePointPageState extends State<BikePointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bikePoint.id),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: NullableText(
              widget.bikePoint.commonName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Place type'),
            subtitle: NullableText(
              widget.bikePoint.placeType,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lat'),
            subtitle: NullableText(
              widget.bikePoint.lat?.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lon'),
            subtitle: NullableText(
              widget.bikePoint.lon?.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Additional properties'),
            onTap: () {
              Navigator.of(context).pushNamed(
                BikePointAdditionalPropertiesPage.route,
                arguments: widget.bikePoint,
              );
            },
          ),
        ],
      ),
    );
  }
}
