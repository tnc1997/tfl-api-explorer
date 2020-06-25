import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/delegates/bike_point_search_delegate.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/place_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';

class BikePointsPage extends StatelessWidget {
  static const routeName = '/bike_points';

  BikePointsPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final bikePointsFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).bikePoints.get();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bike points'),
        actions: <Widget>[
          FutureBuilder<List<Place>>(
            future: bikePointsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: Icon(Mdi.magnify),
                  onPressed: () async {
                    final bikePoint = await showSearch(
                      context: context,
                      delegate: BikePointSearchDelegate(
                        bikePoints: snapshot.data,
                      ),
                    );

                    if (bikePoint != null) {
                      await Navigator.of(context).pushNamed(
                        BikePointPage.routeName,
                        arguments: bikePoint,
                      );
                    }
                  },
                );
              }

              return IconButton(
                icon: Icon(Mdi.magnify),
                onPressed: null,
              );
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Place>>(
        future: bikePointsFuture,
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
              child: Text('N/A'),
            );
          }
        },
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }
}
