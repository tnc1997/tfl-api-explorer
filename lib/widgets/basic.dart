import 'package:flutter/material.dart';

class CircularProgressIndicatorCenter extends Center {
  CircularProgressIndicatorCenter({
    Key key,
    double widthFactor,
    double heightFactor,
  }) : super(
          key: key,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: CircularProgressIndicator(),
        );
}

class TextCenter extends Center {
  TextCenter(
    String data, {
    Key key,
    double widthFactor,
    double heightFactor,
  }) : super(
          key: key,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: Text(data),
        );
}
