import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'bay_list_tile.dart';

class CarParkBaysPage extends StatefulWidget {
  const CarParkBaysPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<CarParkBaysPage> createState() {
    return _CarParkBaysPageState();
  }
}

class _CarParkBaysPageState extends State<CarParkBaysPage> {
  late final Future<CarParkOccupancy> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bays'),
      ),
      body: CircularProgressIndicatorFutureBuilder<CarParkOccupancy>(
        future: _future,
        builder: (context, data) {
          if (data?.bays case final bays?) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return BayListTile(
                  bay: bays[index],
                );
              },
              itemCount: bays.length,
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

    _future = context.read<TflApiClient>().occupancy.get(widget.id);
  }
}
