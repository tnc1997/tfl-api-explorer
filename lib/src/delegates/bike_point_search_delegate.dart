import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/place_common_name_specification.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
import 'package:tfl_api_explorer/src/widgets/place_list_tile.dart';

class BikePointSearchDelegate extends SearchDelegate<Place> {
  BikePointSearchDelegate({
    @required this.bikePointsFuture,
  });

  final Future<List<Place>> bikePointsFuture;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Mdi.close),
        onPressed: () {
          query = '';

          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Mdi.arrowLeft),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return CircularProgressIndicatorFutureBuilder(
      future: bikePointsFuture,
      builder: (context, data) {
        final specification = PlaceCommonNameSpecification(
          commonName: query,
        );

        final bikePoints = data.where(specification.isSatisfiedBy).toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            return PlaceListTile(
              place: bikePoints[index],
              onTap: () {
                close(context, bikePoints[index]);
              },
            );
          },
          itemCount: bikePoints.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CircularProgressIndicatorFutureBuilder(
      future: bikePointsFuture,
      builder: (context, data) {
        final specification = PlaceCommonNameSpecification(
          commonName: query,
        );

        final bikePoints = data.where(specification.isSatisfiedBy).toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: NullableText(
                bikePoints[index].commonName,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                query = bikePoints[index].commonName;

                showResults(context);
              },
            );
          },
          itemCount: bikePoints.length,
        );
      },
    );
  }
}
