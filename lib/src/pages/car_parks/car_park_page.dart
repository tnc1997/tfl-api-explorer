import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_park_bays_page.dart';

class CarParkPage extends StatelessWidget {
  static const routeName = '/car_parks/:id';

  CarParkPage({
    super.key,
    required this.carPark,
  });

  final Place carPark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carPark.id ?? 'Unknown'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: Text(
              carPark.commonName ?? 'Unknown',
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
