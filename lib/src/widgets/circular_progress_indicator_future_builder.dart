import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tfl_api_explorer/src/types/data_widget_builder.dart';

class CircularProgressIndicatorFutureBuilder<T> extends StatelessWidget {
  CircularProgressIndicatorFutureBuilder({
    Key key,
    this.future,
    @required this.builder,
  }) : super(
          key: key,
        );

  final Future<T> future;

  final DataWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return builder(context, snapshot.data);
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
