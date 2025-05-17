import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/models/order.dart';
import 'package:hotel_pos_app/models/order_list.dart';

class OrderListNotifier extends Notifier<OrderList> {
  @override
  OrderList build() {
    return OrderList(orderList: []);
  }

  void addOrder(Order order) {
    state = OrderList(orderList: [...state.orderList, order]);
  }
}

final orderListNotifierProvider =
    NotifierProvider<OrderListNotifier, OrderList>(() {
  return OrderListNotifier();
});
