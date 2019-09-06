import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/drawer.dart';
import '../../material/list_tile.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';
import '../../widgets/basic.dart';

class BikePointsPage extends StatefulWidget {
  static const route = '/bike_points';

  BikePointsPage({Key key}) : super(key: key);

  @override
  _BikePointsPageState createState() => _BikePointsPageState();
}

class _BikePointsPageState extends State<BikePointsPage> {
  Future<List<Place>> _bikePointsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bike points'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Place>>(
        future: _bikePointsFuture,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return BikePointListTile(
                  context: context,
                  bikePoint: data[index],
                );
              },
              itemCount: data.length,
            );
          } else {
            return TextCenter('N/A');
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }

  @override
  void initState() {
    super.initState();

    _bikePointsFuture = Provider.of<TflApiState>(
      context,
      listen: false,
    ).tflApi.bikePoints.get();
  }
}
