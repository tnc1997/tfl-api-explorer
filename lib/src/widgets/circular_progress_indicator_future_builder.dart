import 'package:flutter/material.dart';

class CircularProgressIndicatorFutureBuilder<T> extends StatelessWidget {
  const CircularProgressIndicatorFutureBuilder({
    super.key,
    this.future,
    required this.builder,
  });

  final Future<T>? future;

  final Widget Function(BuildContext context, T? data) builder;

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
