import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/models/tab_state.dart';

class TabNotifier extends Notifier<TabState> {
  @override
  TabState build() {
    return TabState(tabContent: [], tabNames: [], cartIds: []);
  }

  int cartNumber = 0;
  void addTab(String cartId) {
    state = TabState(
        tabNames: [...state.tabNames, (++cartNumber).toString()],
        tabContent: [...state.tabContent, const Text("next")],
        cartIds: [...state.cartIds, cartId]);
  }

  void removeTab(String cartId) {
    final index = state.cartIds.indexWhere((id) => id == cartId);

    final newNames = [...state.tabNames]..removeAt(index);
    final newContent = [...state.tabContent]..removeAt(index);
    final newCartIds = [...state.cartIds]..removeAt(index);

    state = TabState(
        tabNames: newNames, tabContent: newContent, cartIds: newCartIds);
  }
}

final tabNotifierProvider = NotifierProvider<TabNotifier, TabState>(() {
  return TabNotifier();
});
