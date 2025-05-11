import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_pos_app/models/cart_item.dart';
import 'package:hotel_pos_app/models/cart_list.dart';
import 'package:line_icons/line_icon.dart';

import '../models/cart.dart';

class CartListNotifier extends Notifier<CartList> {
  @override
  CartList build() {
    return CartList(cartList: []);
  }

  int getTotalItemInCart(String cartId){
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    return cart.items.length;
  }

  double getTotalPriceOfCart(String cartId) {
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    return cart.items.fold(0.0, (sum, item) => sum + item.totalprice);
  }




  int getQuantity(String cartId, String itemId) {
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    final item = cart.items.firstWhere(
          (item) => item.id == itemId,
      orElse: () => CartItem(id: itemId, name: '', price: 0.0, quantity: 0, totalprice: 0.0),
    );
    return item.quantity;
  }

  double getTotalPrice(String cartId, String itemId) {
    final cart = state.cartList.firstWhere((cart) => cart.cartId == cartId);
    final item = cart.items.firstWhere(
          (item) => item.id == itemId,
      orElse: () => CartItem(id: itemId, name: '', price: 0.0, quantity: 0, totalprice: 0.0),
    );
    return item.totalprice;
  }


  int _nextCartId = 1;

  void addCart() {
    state = CartList(cartList: [
      ...state.cartList,
      Cart(cartId: (_nextCartId++).toString(), items: []),
    ]);
  }

  void addItemToCart(String cartId, CartItem newItem) {
    CartList newCartList = CartList(
        cartList: state.cartList.map((cart) {
      if (cart.cartId == cartId) {
        final requiredIndex =
            cart.items.indexWhere((item) => item.id == newItem.id);
        if (requiredIndex != -1) {
          cart.items[requiredIndex].quantity += 1;
        } else {
          cart.items.add(newItem);
        }
      }
      return cart;
    }).toList());
    state = newCartList;
  }

  void incrementCart(String cartId, String itemId) {
    CartList newCartList = CartList(
        cartList: state.cartList.map((cart) {
      if (cart.cartId == cartId) {
        final item = cart.items.firstWhere((item) => item.id == itemId);
        item.quantity += 1;
        item.totalprice += item.price;
      }

      return cart;
    }).toList());
    state = newCartList;
  }

  void decrementCart(String cartId, String itemId) {
    CartList newCartList = CartList(
        cartList: state.cartList.map((cart) {
      if (cart.cartId == cartId) {
        final item = cart.items.firstWhere((item) => item.id == itemId);
        if(item.quantity != 0){
          item.quantity -= 1;
          item.totalprice -= item.price;
        }
      }
      return cart;
    }).toList());
    state = newCartList;
  }
}

final cartListNotifierProvider =
    NotifierProvider<CartListNotifier, CartList>(() {
  return CartListNotifier();
});
