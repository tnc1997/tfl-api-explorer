import 'package:flutter/material.dart';

import 'line_filters_page.dart';

class LineFiltersButton extends StatelessWidget {
  const LineFiltersButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_alt),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return LineFiltersPage();
            },
          ),
        );
      },
    );
  }
}
