import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../common/circular_progress_indicator_future_builder.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    super.key,
  });

  @override
  State<AboutPage> createState() {
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> {
  late final Future<PackageInfo> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: CircularProgressIndicatorFutureBuilder<PackageInfo>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Package name'),
                  subtitle: Text(data.packageName),
                ),
                ListTile(
                  title: Text('Version'),
                  subtitle: Text(data.version),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _future = PackageInfo.fromPlatform();
  }
}
