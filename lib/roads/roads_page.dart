import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../common/drawer.dart';
import 'road_list_tile.dart';
import 'road_route.dart';
import 'road_search_delegate.dart';
import 'roads_route.dart';

class RoadsPage extends StatefulWidget {
  const RoadsPage({
    super.key,
  });

  @override
  State<RoadsPage> createState() {
    return _RoadsPageState();
  }
}

class _RoadsPageState extends State<RoadsPage> {
  late final Future<List<RoadCorridor>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roads'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final router = GoRouter.of(context);

              final road = await showSearch(
                context: context,
                delegate: RoadSearchDelegate(
                  roadsFuture: _future,
                ),
              );

              if (road != null) {
                router.go(
                  RoadRoute(
                    id: road.id!,
                  ).location,
                );
              }
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RoadCorridor>>(
        future: _future,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RoadListTile(
                  road: data[index],
                  onTap: () {
                    RoadRoute(
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

    _future = context.read<TflApiClient>().road.getAll();
  }
}
