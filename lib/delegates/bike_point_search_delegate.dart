import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/place_common_name_specification.dart';
import '../widgets/text.dart';

class BikePointSearchDelegate extends SearchDelegate<Place> {
  final List<Place> _bikePoints;

  BikePointSearchDelegate(this._bikePoints);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
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
    final specification = PlaceCommonNameSpecification(query);
    final bikePoints = _bikePoints.where(specification.isSatisfiedBy).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: NullableText(
            bikePoints[index].id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            bikePoints[index].commonName,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            close(context, bikePoints[index]);
          },
        );
      },
      itemCount: bikePoints.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final specification = PlaceCommonNameSpecification(query);
    final bikePoints = _bikePoints.where(specification.isSatisfiedBy).toList();

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
  }
}
