import 'package:flutter/material.dart';

class TabState {
  List<String> tabNames;
  List<Widget> tabContent;
  List<String> cartIds;

  TabState(
      {required this.cartIds,
      required this.tabContent,
      required this.tabNames});
  @override
  String toString() {
    return "TabState[tabNames:$tabNames,tabContent:$tabContent,cartIds:$cartIds]";
  }
}
