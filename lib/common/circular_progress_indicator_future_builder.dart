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
        if (snapshot.connectionState == ConnectionState.done) {
          final error = snapshot.error?.toString();

          if (error != null) {
            return Center(
              child: Text(error),
            );
          }

          return builder(context, snapshot.data);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
