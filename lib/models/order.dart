import 'package:uuid/uuid.dart';

class Order {
  final String orderId;
  final String cartId;
  final String itemCount;
  final String totalPrice;
  final DateTime date;

  Order(
      {String? orderId,
      required this.cartId,
      required this.itemCount,
      required this.totalPrice,
      required this.date})
      : orderId = orderId ?? const Uuid().v4();
}
