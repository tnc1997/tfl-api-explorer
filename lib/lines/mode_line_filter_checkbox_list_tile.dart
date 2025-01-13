import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'line_filters_notifier.dart';

class ModeLineFilterCheckboxListTile extends StatelessWidget {
  const ModeLineFilterCheckboxListTile({
    super.key,
    required this.modeName,
  });

  final String modeName;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<LineFiltersNotifier>();

    return CheckboxListTile(
      value: notifier.modes.contains(modeName),
      onChanged: (value) {
        if (value == true) {
          notifier.addMode(modeName);
        } else {
          notifier.removeMode(modeName);
        }
      },
      title: Text(
        modeName,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
