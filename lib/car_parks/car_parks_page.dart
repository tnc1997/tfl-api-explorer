import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../src/delegates/place_search_delegate.dart';
import '../src/widgets/circular_progress_indicator_future_builder.dart';
import '../src/widgets/place_list_tile.dart';
import '../src/widgets/tfl_api_explorer_drawer.dart';
import 'car_park_route.dart';
import 'car_parks_route.dart';

class CarParksPage extends StatefulWidget {
  const CarParksPage({
    super.key,
  });

  @override
  State<CarParksPage> createState() {
    return _CarParksPageState();
  }
}

class _CarParksPageState extends State<CarParksPage> {
  late Future<List<Place>> _carParksFuture;

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
                  placesFuture: _carParksFuture,
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
        future: _carParksFuture,
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

    _carParksFuture = context.read<TflApiClient>().place.getByType(['CarPark']);
  }
}
