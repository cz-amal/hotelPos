import 'package:flutter/material.dart';

class TabState {
  List<String> tabNames;
  List<Widget> tabContent;

  TabState({required this.tabContent, required this.tabNames});
  @override
  String toString(){
    return "TabState[tabNames:$tabNames,tabContent:$tabContent]";
  }
}
