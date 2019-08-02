import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../widgets/text.dart';

class ModeRadioListTile extends RadioListTile<Mode> {
  ModeRadioListTile({
    Key key,
    @required Mode value,
    @required Mode groupValue,
    @required ValueChanged<Mode> onChanged,
  }) : super(
          key: key,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          title: NullableText(
            value.modeName,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            value.isTflService ? 'Operated by TfL' : '',
            overflow: TextOverflow.ellipsis,
          ),
        );
}

class StopPointRadioListTile extends RadioListTile<StopPoint> {
  StopPointRadioListTile({
    Key key,
    @required StopPoint value,
    @required StopPoint groupValue,
    @required ValueChanged<StopPoint> onChanged,
  }) : super(
          key: key,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          title: NullableText(
            value.id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            value.commonName,
            overflow: TextOverflow.ellipsis,
          ),
        );
}
