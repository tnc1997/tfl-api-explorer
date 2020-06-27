import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/delegates/place_search_delegate.dart';
import 'package:tfl_api_explorer/src/pages/car_parks/car_park_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/place_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';

class CarParksPage extends StatefulWidget {
  static const routeName = '/car_parks';

  @override
  _CarParksPageState createState() => _CarParksPageState();
}

class _CarParksPageState extends State<CarParksPage> {
  Future<List<Place>> _carParksFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car parks'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.magnify),
            onPressed: () async {
              final carPark = await showSearch(
                context: context,
                delegate: PlaceSearchDelegate(
                  placesFuture: _carParksFuture,
                ),
              );

              if (carPark != null) {
                await Navigator.of(context).pushNamed(
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
              child: Text('N/A'),
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

    _carParksFuture = context.read<TflApi>().carParks.get();
  }
}
