import 'dart:async';

import 'package:flutter/widgets.dart';

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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicatorCenter();
            }

            if (snapshot.hasError) {
              return TextCenter('${snapshot.error}');
            }

            return builder(context, snapshot.data);
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicatorCenter();
            }

            if (snapshot.hasError) {
              return TextCenter('${snapshot.error}');
            }

            return builder(context, snapshot.data);
          },
        );
}

typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);
