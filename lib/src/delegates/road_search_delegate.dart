import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/road_display_name_specification.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';
import 'package:tfl_api_explorer/src/widgets/road_list_tile.dart';

class RoadSearchDelegate extends SearchDelegate<Road> {
  RoadSearchDelegate({
    @required this.roadsFuture,
  });

  final Future<List<Road>> roadsFuture;

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
    return CircularProgressIndicatorFutureBuilder<List<Road>>(
      future: roadsFuture,
      builder: (context, data) {
        final specification = RoadDisplayNameSpecification(
          displayName: query,
        );

        final roads = data.where(specification.isSatisfiedBy).toList();

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
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CircularProgressIndicatorFutureBuilder<List<Road>>(
      future: roadsFuture,
      builder: (context, data) {
        final specification = RoadDisplayNameSpecification(
          displayName: query,
        );

        final roads = data.where(specification.isSatisfiedBy).toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: NullableText(
                roads[index].displayName,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                query = roads[index].displayName;

                showResults(context);
              },
            );
          },
          itemCount: roads.length,
        );
      },
    );
  }
}
