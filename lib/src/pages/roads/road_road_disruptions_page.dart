import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/road_disruption_list_tile.dart';

class RoadRoadDisruptionsPage extends StatefulWidget {
  static const routeName = '/roads/:id/road_disruptions';

  RoadRoadDisruptionsPage({
    Key key,
    @required this.road,
  }) : super(
          key: key,
        );

  final Road road;

  @override
  _RoadRoadDisruptionsPageState createState() =>
      _RoadRoadDisruptionsPageState();
}

class _RoadRoadDisruptionsPageState extends State<RoadRoadDisruptionsPage> {
  Future<List<RoadDisruption>> _roadDisruptionsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RoadDisruption>>(
          future: _roadDisruptionsFuture,
          builder: (context, data) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RoadDisruptionListTile(
                  roadDisruption: data[index],
                );
              },
              itemCount: data.length,
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    _roadDisruptionsFuture =
        context.read<TflApi>().roads.getRoadDisruptions(widget.road.id);
  }
}
