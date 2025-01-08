import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../widgets/circular_progress_indicator_future_builder.dart';
import 'car_park_bays_page.dart';

class CarParkPage extends StatefulWidget {
  static const routeName = '/car_parks/:id';

  const CarParkPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<CarParkPage> createState() {
    return _CarParkPageState();
  }
}

class _CarParkPageState extends State<CarParkPage> {
  late final Future<Place> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car park'),
      ),
      body: CircularProgressIndicatorFutureBuilder<Place>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: [
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(
                    data.commonName ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Bays'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      CarParkBaysPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
              ],
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

    _future = context.read<TflApiClient>().place.get(widget.id);
  }
}
