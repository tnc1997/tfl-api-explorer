import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../delegates/place_search_delegate.dart';
import '../../widgets/circular_progress_indicator_future_builder.dart';
import '../../widgets/place_list_tile.dart';
import '../../widgets/tfl_api_explorer_drawer.dart';
import 'car_park_page.dart';

class CarParksPage extends StatefulWidget {
  static const routeName = '/car_parks';

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
              final navigator = Navigator.of(context);

              final carPark = await showSearch(
                context: context,
                delegate: PlaceSearchDelegate(
                  placesFuture: _carParksFuture,
                ),
              );

              if (carPark != null) {
                await navigator.pushNamed(
                  CarParkPage.routeName,
                  arguments: carPark,
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
                    Navigator.of(context).pushNamed(
                      CarParkPage.routeName,
                      arguments: data[index],
                    );
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
