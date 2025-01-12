import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await launchUrl(
          Uri.https(
            'api-portal.tfl.gov.uk',
            '/signup',
          ),
        );
      },
      child: const Text('SIGN UP'),
    );
  }
}
