import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import '../places/place_list_tile.dart';
import '../places/place_search_delegate.dart';
import 'bike_point_route.dart';
import 'bike_points_route.dart';

class BikePointsScreen extends StatefulWidget {
  const BikePointsScreen({
    super.key,
  });

  @override
  State<BikePointsScreen> createState() {
    return _BikePointsScreenState();
  }
}

class _BikePointsScreenState extends State<BikePointsScreen> {
  late final Future<List<Place>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bike points'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final router = GoRouter.of(context);

              final bikePoint = await showSearch(
                context: context,
                delegate: PlaceSearchDelegate(
                  placesFuture: _future,
                ),
              );

              if (bikePoint != null) {
                router.go(
                  BikePointRoute(
                    id: bikePoint.id!,
                  ).location,
                );
              }
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Place>>(
        future: _future,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return PlaceListTile(
                  place: data[index],
                  onTap: () {
                    BikePointRoute(
                      id: data[index].id!,
                    ).go(context);
                  },
                );
              },
              itemCount: data.length,
            );
          } else {
            return Center(
              child: Text('Unknown'),
            );
          }
        },
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }

  @override
  void initState() {
    super.initState();

    _future = context.read<TflApiClient>().bikePoint.getAll();
  }
}
