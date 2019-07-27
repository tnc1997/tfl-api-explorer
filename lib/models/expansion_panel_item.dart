import 'package:flutter/material.dart';

class ExpansionPanelItem<T extends Widget> {
  ExpansionPanelItem({
    this.title,
    this.icon,
    this.body,
  }) : isExpanded = false;

  final String title;

  final Icon icon;

  final T body;

  bool isExpanded;
}
