import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/delegates/bike_point_search_delegate.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/bike_point_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/drawer.dart' as drawer;

class BikePointsPage extends StatefulWidget {
  static const route = '/bike_points';

  BikePointsPage({
    Key key,
  }) : super(
          key: key,
        );

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
        actions: <Widget>[
          FutureBuilder<List<Place>>(
            future: _bikePointsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final bikePoint = await showSearch(
                      context: context,
                      delegate: BikePointSearchDelegate(
                        bikePoints: snapshot.data,
                      ),
                    );

                    if (bikePoint != null) {
                      Navigator.of(context).pushNamed(
                        BikePointPage.route,
                        arguments: bikePoint,
                      );
                    }
                  },
                );
              }

              return IconButton(
                icon: Icon(Icons.search),
                onPressed: null,
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Place>>(
        future: _bikePointsFuture,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return BikePointListTile(
                  bikePoint: data[index],
                );
              },
              itemCount: data.length,
            );
          } else {
            return Center(
              child: Text('N/A'),
            );
          }
        },
      ),
      drawer: drawer.Drawer(),
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
