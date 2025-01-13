import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'mode_line_filter_checkbox_list_tile.dart';

class ModeLineFilterExpansionTile extends StatelessWidget {
  const ModeLineFilterExpansionTile({
    super.key,
    required this.modes,
  });

  final List<Mode> modes;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Mode'),
      children: [
        for (final mode in modes)
          if (mode.modeName case final modeName?)
            ModeLineFilterCheckboxListTile(
              modeName: modeName,
            ),
      ],
    );
  }
}
