import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/road_disruption_list_tile.dart';

class RoadRoadDisruptionsPage extends StatefulWidget {
  static const routeName = '/roads/:id/road_disruptions';

  RoadRoadDisruptionsPage({
    super.key,
    required this.road,
  });

  final RoadCorridor road;

  @override
  _RoadRoadDisruptionsPageState createState() =>
      _RoadRoadDisruptionsPageState();
}

class _RoadRoadDisruptionsPageState extends State<RoadRoadDisruptionsPage> {
  late Future<List<RoadDisruption>> _roadDisruptionsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RoadDisruption>>(
        future: _roadDisruptionsFuture,
        builder: (context, data) {
          if (data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RoadDisruptionListTile(
                  roadDisruption: data[index],
                );
              },
              itemCount: data.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _roadDisruptionsFuture =
        context.read<TflApiClient>().road.disruption([widget.road.id!]);
  }
}
