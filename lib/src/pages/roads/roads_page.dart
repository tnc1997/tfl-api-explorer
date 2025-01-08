import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../delegates/road_search_delegate.dart';
import '../../widgets/circular_progress_indicator_future_builder.dart';
import '../../widgets/road_list_tile.dart';
import '../../widgets/tfl_api_explorer_drawer.dart';
import 'road_page.dart';

class RoadsPage extends StatefulWidget {
  static const routeName = '/roads';

  const RoadsPage({
    super.key,
  });

  @override
  State<RoadsPage> createState() {
    return _RoadsPageState();
  }
}

class _RoadsPageState extends State<RoadsPage> {
  late Future<List<RoadCorridor>> _roadsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roads'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final navigator = Navigator.of(context);

              final road = await showSearch(
                context: context,
                delegate: RoadSearchDelegate(
                  roadsFuture: _roadsFuture,
                ),
              );

              if (road != null) {
                await navigator.pushNamed(
                  RoadPage.routeName,
                  arguments: road.id,
                );
              }
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RoadCorridor>>(
        future: _roadsFuture,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RoadListTile(
                  road: data[index],
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RoadPage.routeName,
                      arguments: data[index].id,
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

    _roadsFuture = context.read<TflApiClient>().road.getAll();
  }
}
