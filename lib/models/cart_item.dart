class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;
  double totalprice;

  CartItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      this.totalprice = 0});

  @override
  String toString() {
    return "CartItem[id:$id,name:$name,price:$price,quantity:$quantity,totalprice:$totalprice]";
  }
}
