import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_line_routes_filters_change_notifier.dart';
import '../../widgets/text.dart';

class LineLineRoutesFiltersPage extends StatefulWidget {
  LineLineRoutesFiltersPage({Key key}) : super(key: key);

  @override
  _LineLineRoutesFiltersPageState createState() =>
      _LineLineRoutesFiltersPageState();
}

class _LineLineRoutesFiltersPageState extends State<LineLineRoutesFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
      ),
      body: Consumer<LineLineRoutesFiltersChangeNotifier>(
        builder: (context, lineLineRoutesFilters, child) {
          final entries = lineLineRoutesFilters.specifications.entries.toList();

          return ListView.builder(
            itemBuilder: (context, index) {
              return AlignedListTile(
                title: Text(entries[index].key),
                subtitle: NullableText(
                  entries[index].value?.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    lineLineRoutesFilters.update(entries[index].key, null);
                  },
                ),
              );
            },
            itemCount: entries.length,
          );
        },
      ),
    );
  }
}
