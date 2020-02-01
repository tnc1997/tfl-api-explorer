import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class AboutPage extends StatelessWidget {
  AboutPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final packageInfoFuture = PackageInfo.fromPlatform();

    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: CircularProgressIndicatorFutureBuilder<PackageInfo>(
        future: packageInfoFuture,
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Package name'),
                subtitle: NullableText(data.packageName),
              ),
              ListTile(
                title: Text('Version'),
                subtitle: NullableText(data.version),
              ),
            ],
          );
        },
      ),
    );
  }
}
