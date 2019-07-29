import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'basic.dart';

class CircularProgressIndicatorFutureBuilder<T> extends FutureBuilder<T> {
  CircularProgressIndicatorFutureBuilder({
    Key key,
    Future<T> future,
    @required DataWidgetBuilder<T> builder,
  }) : super(
          key: key,
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return builder(context, snapshot.data);
            } else if (snapshot.hasError) {
              return TextCenter('${snapshot.error}');
            } else {
              return CircularProgressIndicatorCenter();
            }
          },
        );
}

class CircularProgressIndicatorStreamBuilder<T> extends StreamBuilder<T> {
  CircularProgressIndicatorStreamBuilder({
    Key key,
    Stream<T> stream,
    @required DataWidgetBuilder<T> builder,
  }) : super(
          key: key,
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return builder(context, snapshot.data);
            } else if (snapshot.hasError) {
              return TextCenter('${snapshot.error}');
            } else {
              return CircularProgressIndicatorCenter();
            }
          },
        );
}

typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);
