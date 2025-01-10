import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../delegates/place_search_delegate.dart';
import '../../widgets/circular_progress_indicator_future_builder.dart';
import '../../widgets/place_list_tile.dart';
import '../../widgets/tfl_api_explorer_drawer.dart';

class BikePointsPage extends StatefulWidget {
  const BikePointsPage({
    super.key,
  });

  @override
  State<BikePointsPage> createState() {
    return _BikePointsPageState();
  }
}

class _BikePointsPageState extends State<BikePointsPage> {
  late Future<List<Place>> _bikePointsFuture;

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
                  placesFuture: _bikePointsFuture,
                ),
              );

              if (bikePoint != null) {
                router.go('/bike-points/${bikePoint.id}');
              }
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
                return PlaceListTile(
                  place: data[index],
                  onTap: () {
                    context.go('/bike-points/${data[index].id}');
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

    _bikePointsFuture = context.read<TflApiClient>().bikePoint.getAll();
  }
}
