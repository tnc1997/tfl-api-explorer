import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/bay_list_tile.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';

class CarParkBaysPage extends StatefulWidget {
  static const routeName = '/car_parks/:id/bays';

  const CarParkBaysPage({
    super.key,
    required this.carPark,
  });

  final Place carPark;

  @override
  State<CarParkBaysPage> createState() {
    return _CarParkBaysPageState();
  }
}

class _CarParkBaysPageState extends State<CarParkBaysPage> {
  late Future<List<Bay>> _baysFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bays'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Bay>>(
          future: _baysFuture,
          builder: (context, data) {
            if (data != null) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return BayListTile(
                    bay: data[index],
                  );
                },
                itemCount: data.length,
              );
            } else {
              return Container();
            }
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    _baysFuture = context
        .read<TflApiClient>()
        .occupancy
        .get(widget.carPark.id!)
        .then((value) => value.bays!);
  }
}
