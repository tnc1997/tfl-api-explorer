import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'place_common_name_specification.dart';
import 'place_list_tile.dart';

class PlaceSearchDelegate extends SearchDelegate<Place?> {
  PlaceSearchDelegate({
    required this.placesFuture,
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
        icon: Icon(Icons.close),
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
      icon: Icon(Icons.arrow_back),
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

        final places = data?.where(specification.isSatisfiedBy).toList();

        if (places != null) {
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
        } else {
          return Container();
        }
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

        final places = data?.where(specification.isSatisfiedBy).toList();

        if (places != null) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  places[index].commonName ?? 'Unknown',
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  query = places[index].commonName ?? '';

                  showResults(context);
                },
              );
            },
            itemCount: places.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
