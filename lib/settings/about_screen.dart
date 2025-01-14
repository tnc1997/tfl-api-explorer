import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../common/circular_progress_indicator_future_builder.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    super.key,
  });

  @override
  State<AboutScreen> createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {
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
