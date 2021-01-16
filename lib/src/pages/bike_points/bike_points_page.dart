import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/delegates/place_search_delegate.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/place_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';

class BikePointsPage extends StatefulWidget {
  static const routeName = '/bike_points';

  @override
  _BikePointsPageState createState() => _BikePointsPageState();
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
            icon: Icon(Mdi.magnify),
            onPressed: () async {
              final bikePoint = await showSearch(
                context: context,
                delegate: PlaceSearchDelegate(
                  placesFuture: _bikePointsFuture,
                ),
              );

              if (bikePoint != null) {
                await Navigator.of(context).pushNamed(
                  BikePointPage.routeName,
                  arguments: bikePoint,
                );
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
                    Navigator.of(context).pushNamed(
                      BikePointPage.routeName,
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

    _bikePointsFuture = context.read<TflApiClient>().bikePoints.getAll();
  }
}
