import 'package:flutter/material.dart';

import 'app_key_form_field.dart';
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
            child: AppKeyFormField(
              controller: widget.appKeyController,
              onFieldSubmitted: (value) {
                widget.onSubmitted?.call();
              },
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
}
