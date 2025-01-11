import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../common/circular_progress_indicator_future_builder.dart';
import '../specifications/road_display_name_specification.dart';
import '../widgets/road_list_tile.dart';

class RoadSearchDelegate extends SearchDelegate<RoadCorridor?> {
  RoadSearchDelegate({
    required this.roadsFuture,
  });

  final Future<List<RoadCorridor>> roadsFuture;

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
    return CircularProgressIndicatorFutureBuilder<List<RoadCorridor>>(
      future: roadsFuture,
      builder: (context, data) {
        final specification = RoadDisplayNameSpecification(
          displayName: query,
        );

        final roads = data?.where(specification.isSatisfiedBy).toList();

        if (roads != null) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return RoadListTile(
                road: roads[index],
                onTap: () {
                  close(context, roads[index]);
                },
              );
            },
            itemCount: roads.length,
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CircularProgressIndicatorFutureBuilder<List<RoadCorridor>>(
      future: roadsFuture,
      builder: (context, data) {
        final specification = RoadDisplayNameSpecification(
          displayName: query,
        );

        final roads = data?.where(specification.isSatisfiedBy).toList();

        if (roads != null) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  roads[index].displayName ?? 'Unknown',
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  query = roads[index].displayName ?? '';

                  showResults(context);
                },
              );
            },
            itemCount: roads.length,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
