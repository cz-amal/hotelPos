import 'package:uuid/uuid.dart';

import 'cart_item.dart';

class Cart {
  final String cartId;
  List<CartItem> items;
  Cart({String? cartId, required this.items})
      : cartId = cartId ?? const Uuid().v4();

  @override
  String toString() {
    return "Cart[cartId:$cartId,items:$items]";
  }
}
