import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'filters_notifier.dart';

class ResetFiltersButton<T extends FiltersNotifier> extends StatelessWidget {
  const ResetFiltersButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.restore),
      onPressed: () {
        context.read<T>().reset();
      },
    );
  }
}
