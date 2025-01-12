import 'package:flutter/material.dart';

import 'sign_in_button.dart';
import 'sign_up_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
    this.formKey,
    this.appKeyController,
    this.onSubmitted,
  });

  final GlobalKey<FormState>? formKey;

  final TextEditingController? appKeyController;

  final void Function()? onSubmitted;

  @override
  State<SignInForm> createState() {
    return _SignInFormState();
  }
}

class _SignInFormState extends State<SignInForm> {
  late FocusNode _appKeyFocusNode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: TextFormField(
              controller: widget.appKeyController,
              focusNode: _appKeyFocusNode,
              decoration: InputDecoration(
                labelText: 'App key',
                border: const OutlineInputBorder(),
              ),
              onFieldSubmitted: (value) {
                _appKeyFocusNode.unfocus();

                final onSubmitted = widget.onSubmitted;
                if (onSubmitted != null) {
                  onSubmitted();
                }
              },
              validator: _validator,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OverflowBar(
              spacing: 8.0,
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                const SignUpButton(),
                SignInButton(
                  onPressed: widget.onSubmitted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _appKeyFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _appKeyFocusNode = FocusNode();
  }

  String? _validator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter a value.';
    }

    return null;
  }
}
