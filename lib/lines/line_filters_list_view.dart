import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'mode_line_filter_expansion_tile.dart';

class LineFiltersListView extends StatelessWidget {
  const LineFiltersListView({
    super.key,
    required this.modes,
  });

  final List<Mode> modes;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ModeLineFilterExpansionTile(
          modes: modes,
        ),
      ],
    );
  }
}
