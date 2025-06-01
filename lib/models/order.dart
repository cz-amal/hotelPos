import 'package:uuid/uuid.dart';

import 'cart_item.dart';

class Order {
  final String orderId;
  List<CartItem> items;
  final String itemCount;
  final String totalPrice;
  final DateTime date;

  Order(
      {String? orderId,
      required this.items,
      required this.itemCount,
      required this.totalPrice,
      required this.date})
      : orderId = orderId ?? const Uuid().v4();
}
