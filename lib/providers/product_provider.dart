

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/products.dart';

List<Product> products = [
  Product(
      id: "1",
      price: 20,
      name: "burger",
      description: "nice chicken burger",
      stock: 100,
      imagepath: "/lib/assets/images/burger.jpg"),
  Product(
      id: "2",
      price: 10,
      name: "noodles",
      description: "nice chicken noodles",
      stock: 100,
      imagepath: "/lib/assets/images/burger.jpg"),
];

final productProvider = Provider((ref) {
  return products;
});
