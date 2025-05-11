import 'package:line_icons/line_icon.dart';

import 'cart_item.dart';

class Cart {
  final String cartId;
  List<CartItem> items;
  Cart({required this.cartId, required this.items});

  @override
  String toString(){
    return "Cart[cartId:$cartId,items:$items]";
  }
}
