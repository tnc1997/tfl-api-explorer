import 'package:flutter/material.dart';

class AppKeyFormField extends StatelessWidget {
  const AppKeyFormField({
    super.key,
    this.controller,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;

  final void Function(String value)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'App key',
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: onFieldSubmitted,
      validator: (value) {
        if (value?.isEmpty != false) {
          return 'Please enter a value.';
        }

        return null;
      },
    );
  }
}
