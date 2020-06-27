import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_park_bays_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class CarParkPage extends StatelessWidget {
  static const routeName = '/car_parks/:id';

  CarParkPage({
    Key key,
    @required this.carPark,
  }) : super(
          key: key,
        );

  final Place carPark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carPark.id),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: NullableText(
              carPark.commonName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Place type'),
            subtitle: NullableText(
              carPark.placeType,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lat'),
            subtitle: NullableText(
              carPark.lat?.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Lon'),
            subtitle: NullableText(
              carPark.lon?.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Bays'),
            onTap: () {
              Navigator.of(context).pushNamed(
                CarParkBaysPage.routeName,
                arguments: carPark,
              );
            },
          ),
        ],
      ),
    );
  }
}
