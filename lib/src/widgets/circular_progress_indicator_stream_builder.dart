import 'package:flutter/material.dart';

class CircularProgressIndicatorStreamBuilder<T> extends StatelessWidget {
  CircularProgressIndicatorStreamBuilder({
    Key key,
    this.stream,
    @required this.builder,
  }) : super(
          key: key,
        );

  final Stream<T> stream;

  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
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
