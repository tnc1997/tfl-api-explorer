import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../routes/bike_points/bike_point_additional_properties_route.dart';
import '../../routes/bike_points/bike_points_route.dart';
import '../../widgets/circular_progress_indicator_future_builder.dart';

class BikePointPage extends StatefulWidget {
  const BikePointPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<BikePointPage> createState() {
    return _BikePointPageState();
  }
}

class _BikePointPageState extends State<BikePointPage> {
  late final Future<Place> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bike point'),
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
                ListTile(
                  title: Text('Place type'),
                  subtitle: Text(
                    data.placeType ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Lat'),
                  subtitle: Text(
                    data.lat?.toString() ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Lon'),
                  subtitle: Text(
                    data.lon?.toString() ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Additional properties'),
                  onTap: () {
                    BikePointAdditionalPropertiesRoute(
                      id: widget.id,
                    ).go(context);
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

    _future = context.read<TflApiClient>().bikePoint.get(widget.id);
  }
}
