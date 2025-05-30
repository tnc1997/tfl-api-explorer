import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import '../places/place_list_tile.dart';
import '../places/place_search_delegate.dart';
import 'car_park_route.dart';
import 'car_parks_route.dart';

class CarParksScreen extends StatefulWidget {
  const CarParksScreen({
    super.key,
  });

  @override
  State<CarParksScreen> createState() {
    return _CarParksScreenState();
  }
}

class _CarParksScreenState extends State<CarParksScreen> {
  late final Future<List<Place>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car parks'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final router = GoRouter.of(context);

              final carPark = await showSearch(
                context: context,
                delegate: PlaceSearchDelegate(
                  placesFuture: _future,
                ),
              );

              if (carPark != null) {
                router.go(
                  CarParkRoute(
                    id: carPark.id!,
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
                    CarParkRoute(
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

    _future = context.read<TflApiClient>().place.getByType(['CarPark']);
  }
}
