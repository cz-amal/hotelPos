import 'package:uuid/uuid.dart';

class CartItem {
  final String itemId;
  final String name;
  final double price;
  int quantity;
  double totalprice;

  CartItem(
      {String? itemId,
      required this.name,
      required this.price,
      required this.quantity,
      this.totalprice = 0})
      : itemId = itemId ?? const Uuid().v4();

  @override
  String toString() {
    return "CartItem[id:$itemId,name:$name,price:$price,quantity:$quantity,totalprice:$totalprice]";
  }
}
