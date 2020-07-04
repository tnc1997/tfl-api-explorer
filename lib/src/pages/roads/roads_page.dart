import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/delegates/road_search_delegate.dart';
import 'package:tfl_api_explorer/src/pages/roads/road_page.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/road_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';

class RoadsPage extends StatefulWidget {
  static const routeName = '/roads';

  @override
  _RoadsPageState createState() => _RoadsPageState();
}

class _RoadsPageState extends State<RoadsPage> {
  Future<List<Road>> _roadsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roads'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Mdi.magnify),
            onPressed: () async {
              final road = await showSearch(
                context: context,
                delegate: RoadSearchDelegate(
                  roadsFuture: _roadsFuture,
                ),
              );

              if (road != null) {
                await Navigator.of(context).pushNamed(
                  RoadPage.routeName,
                  arguments: road,
                );
              }
            },
          ),
        ],
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Road>>(
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

    _roadsFuture = context.read<TflApi>().roads.get();
  }
}
