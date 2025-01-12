import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.login),
      label: const Text('SIGN IN'),
    );
  }
}
