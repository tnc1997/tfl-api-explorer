import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/place_common_name_specification.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
import 'package:tfl_api_explorer/src/widgets/place_list_tile.dart';

class PlaceSearchDelegate extends SearchDelegate<Place> {
  PlaceSearchDelegate({
    @required this.placesFuture,
  });

  final Future<List<Place>> placesFuture;

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
    return CircularProgressIndicatorFutureBuilder<List<Place>>(
      future: placesFuture,
      builder: (context, data) {
        final specification = PlaceCommonNameSpecification(
          commonName: query,
        );

        final places = data.where(specification.isSatisfiedBy).toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            return PlaceListTile(
              place: places[index],
              onTap: () {
                close(context, places[index]);
              },
            );
          },
          itemCount: places.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CircularProgressIndicatorFutureBuilder<List<Place>>(
      future: placesFuture,
      builder: (context, data) {
        final specification = PlaceCommonNameSpecification(
          commonName: query,
        );

        final places = data.where(specification.isSatisfiedBy).toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: NullableText(
                places[index].commonName,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                query = places[index].commonName;

                showResults(context);
              },
            );
          },
          itemCount: places.length,
        );
      },
    );
  }
}
