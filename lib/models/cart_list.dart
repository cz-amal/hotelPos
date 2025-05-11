
import 'cart.dart';

class CartList{
  List<Cart> cartList;
  CartList({required this.cartList});

  @override
  String toString(){
    return "CartList[cartList:$cartList]";
  }

}