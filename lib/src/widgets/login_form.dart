import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
    this.formKey,
    this.appIdController,
    this.appKeyController,
    this.onSubmitted,
  }) : super(
          key: key,
        );

  final GlobalKey<FormState> formKey;

  final TextEditingController appIdController;

  final TextEditingController appKeyController;

  final void Function() onSubmitted;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FocusNode _appIdFocusNode;
  FocusNode _appKeyFocusNode;

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
              controller: widget.appIdController,
              focusNode: _appIdFocusNode,
              decoration: InputDecoration(
                labelText: 'App ID',
              ),
              onFieldSubmitted: (value) {
                _appKeyFocusNode.requestFocus();
              },
              validator: _validator,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: TextFormField(
              controller: widget.appKeyController,
              focusNode: _appKeyFocusNode,
              decoration: InputDecoration(
                labelText: 'App key',
              ),
              onFieldSubmitted: (value) {
                _appKeyFocusNode.unfocus();

                if (widget.onSubmitted != null) {
                  widget.onSubmitted();
                }
              },
              validator: _validator,
            ),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  await launch('https://api-portal.tfl.gov.uk/signup');
                },
                child: Text('Sign up'),
              ),
              RaisedButton(
                onPressed: widget.onSubmitted,
                child: Text('Sign in'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _appIdFocusNode.dispose();
    _appKeyFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _appIdFocusNode = FocusNode();
    _appKeyFocusNode = FocusNode();
  }

  String _validator(String value) {
    if (value.isEmpty) {
      return 'Please enter a value.';
    }

    return null;
  }
}
