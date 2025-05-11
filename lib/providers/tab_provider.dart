import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/models/tab_state.dart';

class TabNotifier extends Notifier<TabState> {
  @override
  TabState build() {
    return TabState(tabContent: [], tabNames: []);
  }
  int cartNumber = 0;
  void addTab() {
    state = TabState(
      tabNames: [...state.tabNames, (++cartNumber).toString()],
      tabContent: [...state.tabContent, Text("next")],
    );
  }

  void removeTab(int index) {
    final newNames = [...state.tabNames]..removeAt(index);
    final newContent = [...state.tabContent]..removeAt(index);

    state = TabState(
      tabNames: newNames,
      tabContent: newContent,
    );
  }
}

final tabNotifierProvider = NotifierProvider<TabNotifier, TabState>(() {
  return TabNotifier();
});
