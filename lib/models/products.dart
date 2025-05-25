import 'cart_item.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final int stock;
  final double price;
  final String imagepath;

  Product(
      {required this.id,
      required this.price,
      required this.name,
      required this.description,
      required this.stock,
      required this.imagepath});
  @override
  String toString(){
    return "Product[id:$id,name:$name,description:$description,stock:$stock,price:$price]";
  }
}

extension ProductToCartItem on Product {
  CartItem toCartItem() {
    return CartItem(
      itemId: id,
      name: name,
      price: price,
      quantity: 1,
      totalprice: price.toDouble()
    );
  }
}
